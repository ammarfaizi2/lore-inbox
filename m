Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUDGXTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUDGXTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:19:50 -0400
Received: from mail0.lsil.com ([147.145.40.20]:40397 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261244AbUDGXTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:19:45 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C7B4@exa-atlanta.se.lsil.com>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'jgarzik@pobox.com'" <jgarzik@pobox.com>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>
Cc: "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE][RELEASE]: megaraid unified driver version 2.20.0.B1
Date: Wed, 7 Apr 2004 19:18:02 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

We are releasing the megaraid unified driver version 2.20.0.0.
The source is available at our public ftp site:

ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-unified-2.20.0.B1.04.0
7.2004/

Kernels:
---------
This driver is primarily for lk 2.6. While this also works on lk 2.4
this is not a replacement for the extant 2.x driver on 2.4 kernel.

Thanks to:
-----------
This driver has been designed according to the great inputs by
Jeff Garzik and Matt Domsch. 'readme' in the source tgz has more
details. Thanks in advance also to Paul Wagland for the sysfs
support that he agreed to add.

Near-term goals:
------------------
i.	A new class of controllers will be added under this umbrella.
ii.	Paul Wagland has agreed to start off adding sysfs support to 
	the common module.
iii.	Information exported via sysfs will be fully augmented to allow
	sophisticated monitoring.
iv.	Write support will be added through sysfs.
v.	We are NOT planning to have /proc support in this driver.

Thanks,
Sreenivas
LSI Logic
