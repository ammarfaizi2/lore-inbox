Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTI0Fs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 01:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTI0Fs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 01:48:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:19092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262373AbTI0FsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 01:48:25 -0400
Date: Fri, 26 Sep 2003 22:48:24 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309270548.h8R5mOxg031782@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 10 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/hamradio/baycom_par.c:518: warning: implicit declaration of function `hdlcdrv_register'
drivers/net/hamradio/baycom_par.c:520: warning: assignment makes pointer from integer without a cast
drivers/net/hamradio/baycom_par.c:544: warning: implicit declaration of function `hdlcdrv_unregister'
drivers/net/hamradio/baycom_ser_fdx.c:641: warning: implicit declaration of function `hdlcdrv_register'
drivers/net/hamradio/baycom_ser_fdx.c:643: warning: assignment makes pointer from integer without a cast
drivers/net/hamradio/baycom_ser_fdx.c:667: warning: implicit declaration of function `hdlcdrv_unregister'
drivers/net/hamradio/baycom_ser_hdx.c:678: warning: implicit declaration of function `hdlcdrv_register'
drivers/net/hamradio/baycom_ser_hdx.c:680: warning: assignment makes pointer from integer without a cast
drivers/net/hamradio/baycom_ser_hdx.c:704: warning: implicit declaration of function `hdlcdrv_unregister'
drivers/net/sk98lin/skdim.c:322: warning: unused variable `SKNumCpus'
