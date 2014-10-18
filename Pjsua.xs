#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <pjsua-lib/pjsua.h>

int isInit = 0;

int
init(){
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


MODULE = Pjsua PACKAGE = Pjsua

int
start()
CODE:
  return init();
