Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTKJFZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 00:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbTKJFZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 00:25:08 -0500
Received: from [202.54.110.230] ([202.54.110.230]:21150 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S262906AbTKJFZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 00:25:05 -0500
Message-ID: <1B3885BC15C7024C845AAC78314766C5A26B55@EXCH-01>
From: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
To: Ameya Mitragotri <ameya.mitragotri@wipro.com>,
       "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: problem in booting HP zx6000 with stock kernel 2.5.75
Date: Mon, 10 Nov 2003 10:58:19 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com> wrote 
> in message
> news:<Q08Y.87p.3@gated-at.bofh.it>...
> > 5. The kernel hangs after uncompressing the kernel successfully.
> Nothing is
> > working here, neither keyboard nor anything else.
> 
> Which SCSI driver is configured? I had a qla driver and i faced a
> panic while booting 2.6.0-test5. This patch solved my problem
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0309.2/0331.html
> 

In my case after uncompressing the kernel, it just hangs. Even the SCSI disk
driver is not loaded, so i guess problem is some where else. I am using
Symbios (SYM53C8XX) driver. 

Thanks
Deepak.
