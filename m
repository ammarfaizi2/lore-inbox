Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUBXOrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUBXOrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:47:22 -0500
Received: from mail0.lsil.com ([147.145.40.20]:1452 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262263AbUBXOrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:47:19 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC3D9@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug 
	fix)
Date: Tue, 24 Feb 2004 09:47:06 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> The following patch fixes a bug in megaraid driver version 2.10.1
> >> where irq was erroneously being disabled.
> >
> > Could we have a later version than 2.00.3 in 2.6 please?
We are in process of releasing a unified driver, which will natively support
the 2.4.x and 2.6.x kernels. 

Thanks
-Atul Mukker
