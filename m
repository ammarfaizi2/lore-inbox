Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTLWHMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 02:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLWHMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 02:12:09 -0500
Received: from [203.81.192.10] ([203.81.192.10]:50881 "EHLO
	ns3.worldcall.net.pk") by vger.kernel.org with ESMTP
	id S264966AbTLWHMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 02:12:06 -0500
Message-ID: <008601c3c924$13555170$23c051cb@ns3.worldcall.net.pk>
From: "Muhammad Talha" <talha@worldcall.net.pk>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.0 compilation help
Date: Tue, 23 Dec 2003 12:12:02 +0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

i have Red Hat 9 i am trying to install kernel 2.6.0 . kernel seems to
compiled ok but does not boot
give following error at boot all drive are detected before boot.

module-init-tools 0.9.9 installed
ext3 filesystem support was build in the kernel
aslo /dev file system support buildin
my root parttion is /dev/sda1 ( ext3)
my .config

http://mail.magic.net.pk/kernel/.config


Error Message ##

VFS: Cannot open root device "sda1" or unknown-block(0,0)
Please append a correct "root="boot option
Kernel Panic : VFS Uanble to mount root fs on unknown-block(0,0)

i have following Hardware

Intel Entry level Server motherboard
Pentitum III 1266 MHz processor
2 GB RAM
3 SCSI hard drive
no ide drive

i have tried many time with different option but with no luck

Thanks waiting for your reply

Talha

