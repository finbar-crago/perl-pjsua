#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <pjsua-lib/pjsua.h>

int isInit = 0;

int init(){
  if(!isInit){
    pj_status_t rc;
    rc = pjsua_create();
    if(rc != PJ_SUCCESS)
      return -1;

    { pjsua_config cfg;
      pjsua_logging_config log_cfg;

      pjsua_config_default(&cfg);
      log_cfg.level = 0;
      log_cfg.console_level = 0;
      pjsua_logging_config_default(&log_cfg);

      rc = pjsua_init(&cfg, &log_cfg, NULL);
      if(rc != PJ_SUCCESS)
	return -1;
    }

    { pjsua_transport_config cfg;
      pjsua_transport_config_default(&cfg);
      cfg.port = 5060;
      rc = pjsua_transport_create(PJSIP_TRANSPORT_UDP, &cfg, NULL);
      if(rc != PJ_SUCCESS)
	return -1;
    }

    rc = pjsua_start();
    if(rc != PJ_SUCCESS)
      return -1;

    isInit = 1;
  }
  return 0;
}

int add_account(char *host, char *user, char *pass){
  char sip_url[128];
  sprintf(sip_url, "sip:%s@%s", user, host);
  if(pjsua_verify_sip_url(&sip_url) != PJ_SUCCESS) return -1;

  char sip_uri[128];
  sprintf(sip_uri, "sip:%s", host);

  pj_str_t pj_id = pj_str(sip_url);
  pj_str_t pj_reg_uri = pj_str(sip_uri);
  pj_str_t pj_user = pj_str(user);
  pj_str_t pj_pass = pj_str(pass);

  int acc_id;
  pj_status_t rc;
  pjsua_acc_config cfg;

  pjsua_acc_config_default(&cfg);
  cfg.id = pj_id;
  cfg.reg_uri = pj_reg_uri;
  cfg.cred_count = 1;
  cfg.cred_info[0].realm = pj_reg_uri;
  cfg.cred_info[0].scheme = pj_str("digest");
  cfg.cred_info[0].username = pj_user;
  cfg.cred_info[0].data_type = PJSIP_CRED_DATA_PLAIN_PASSWD;
  cfg.cred_info[0].data = pj_pass;
  rc = pjsua_acc_add(&cfg, PJ_TRUE, &acc_id);

  return (rc==PJ_SUCCESS)?(int)acc_id:-1;
}


MODULE = Pjsua PACKAGE = Pjsua

int
start()
CODE:
  return init();


int
add_account_xs(host, user, pass)
char *host
char *user
char *pass
CODE:
  RETVAL = add_account(host, user, pass);
OUTPUT:
  RETVAL


int
call_xs(acc_id, uri)
int acc_id
char *uri
CODE:
  pj_status_t rc;
  pjsua_call_id call_id;
  pj_str_t pj_uri = pj_str(uri);
  rc = pjsua_call_make_call((pjsua_acc_id)acc_id, &pj_uri, 0, NULL, NULL, &call_id);
  RETVAL = (rc==PJ_SUCCESS)?(int)call_id:-1;
OUTPUT:
  RETVAL
