Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTLZXAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbTLZXAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:00:43 -0500
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:40069 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264461AbTLZXAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:00:42 -0500
Message-Id: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com>
X-Nil: 
Date: Sat, 27 Dec 2003 10:00:23 +1100
To: Linux Mailing List <linux-kernel@vger.kernel.org>
From: Leon Toh <tltoh@attglobal.net>
Subject: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel
  Configuration Tool
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merry Christmas Everyone,

I just downloaded full source code of linux-2.6.0 to start doing some work 
and testing of  Adaptec/DPT I2O controller's. This is when I happen to 
notice Adapec/DPT I2O option have been omitted from Linux Kernel 2.6.0 
Configuration tool.

Typically this option is located in *Device Drivers -> SCSI device support 
-> SCSI low-level drivers*. Furthermore it is also not listed in *Device 
Drivers -> I2O device support* also. And the driver source (dpti2o) is 
residing in /drivers/scsi.

Please advice how should I than go about in hacking Linux 2.6.0 Kernel 
Configuration tool to include Adaptec/DPT I2O support ?

Also any reason for the Adaptec/DPT I2O option being omitted out from Linux 
Kernel configuration tool  ? Or is it just happen to be accidental ? Will 
this be option made available in the next release or pre-release of 2.6 
kernel than ?

Thanks in advance.


Best Regards,
Leon 

