Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261667AbTCGQwO>; Fri, 7 Mar 2003 11:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261671AbTCGQwO>; Fri, 7 Mar 2003 11:52:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261667AbTCGQwN>;
	Fri, 7 Mar 2003 11:52:13 -0500
Subject: I2O on 2.5.64
From: Stephen Hemminger <shemminger@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047056563.11864.104.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 09:02:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled I2O on a test machine running 2.5.64 and it hangs during boot.
Don't think the machine has SCSI but doesn't have any I2O capable
devices.

Last gasp:

Linux I2O PCI support (c) 1999-2002 Red Hat.
i2o: Checking for PCI I2O controllers...
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 44
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes @ f7fe6ec0
  (512 byte buffers X 4 can_queue X 0 i2o controllers)



