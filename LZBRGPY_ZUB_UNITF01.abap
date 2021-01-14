*&---------------------------------------------------------------------*
*& FORM ZF_CREATE
*----------------------------------------------------------------------*
FORM zf_CREATE.

  zbrtpy_zbus_unit-uname = sy-uname.
  zbrtpy_zbus_unit-aedtm = sy-datum.
  zbrtpy_zbus_unit-uzeit = sy-uzeit.

ENDFORM.

*&---------------------------------------------------------------------*
*& FORM ZF_UPDATE
*----------------------------------------------------------------------*
FORM zf_update.

  DATA: l_index LIKE sy-tabix.

  LOOP AT total.
    CHECK <action> = aendern.
    READ TABLE extract WITH KEY <vim_xtotal_key>.
    IF sy-subrc EQ 0.
      CHECK <status>-upd_flag EQ abap_true.
      l_index = sy-tabix.
    ELSE.
      CLEAR l_index.
    ENDIF.

    MOVE extract TO zbrtpy_zbus_unit.
    zbrtpy_zbus_unit-uname = sy-uname.
    zbrtpy_zbus_unit-aedtm = sy-datum.
    zbrtpy_zbus_unit-uzeit = sy-uzeit.
    MOVE zbrtpy_zbus_unit TO total.

    MODIFY zbrtpy_zbus_unit.

    CHECK l_index GT 0.
    MODIFY total INDEX l_index.
    MOVE total TO zbrtpy_zbus_unit.
    MODIFY extract INDEX l_index.
  ENDLOOP.

  sy-subrc = 0.

ENDFORM.