Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUJUMrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUJUMrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268766AbUJUMpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:45:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:24481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268723AbUJUMkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:40:15 -0400
Date: Thu, 21 Oct 2004 05:40:13 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200410211240.i9LCeDk8015277@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9 - 2004-10-20.21.30) - 11 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/drm/drm_agpsupport.h:431: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:582)
drivers/char/drm/drm_stub.h:148: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:582)
drivers/char/drm/drm_stub.h:150: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:578)
drivers/char/drm/drm_stub.h:206: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:577)
drivers/char/drm/drm_stub.h:216: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:578)
drivers/char/mem.c:213: warning: `remap_page_range' is deprecated (declared at include/linux/mm.h:767)
drivers/media/dvb/dibusb/dvb-dibusb.c:308: warning: `dibusb_interrupt_read_loop' defined but not used
drivers/media/dvb/dibusb/dvb-dibusb.c:318: warning: `dibusb_read_remote_control' defined but not used
drivers/media/dvb/dibusb/dvb-dibusb.c:345: warning: `dibusb_hw_sleep' defined but not used
drivers/media/dvb/dibusb/dvb-dibusb.c:351: warning: `dibusb_hw_wakeup' defined but not used
drivers/media/video/cx88/cx88-blackbird.c:367: warning: long int format, size_t arg (arg 3)
