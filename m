Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUELOp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUELOp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 10:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUELOp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 10:45:27 -0400
Received: from mail.uk.thalesgroup.com ([194.128.85.6]:31241 "EHLO
	crawsmail1.uk.thalesgroup.com") by vger.kernel.org with ESMTP
	id S265097AbUELOpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 10:45:20 -0400
Message-ID: <40A23879.4090008@uk.thalesgroup.com>
From: Fisher Alex <Alex.Fisher@uk.thalesgroup.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) on Linux status report
Date: Wed, 12 May 2004 15:45:13 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Serial ATA (SATA) for Linux
> status report
> May 10, 2004
> 
> 
> Hardware support
> ================
> 


> Marvell
> -------
> libata driver status: in progress
> 


Hi.
Does anybody know when this driver might become available?
I'm currently trying to operate a Marvell 88SX6041 with a binary only 
module and read operations from multiple disks are giving me grief :(

I've noticed that sata support will be going into 2.4.27 and the patch 
looks very clean.  Will backporting sata support to an older 2.4.20-pre2 
kernel (http://source.mvista.com:14690//linuxppc_2_4_galileo) be as 
hassle free?


Many thanks,
Alex


This email and any attachments are confidential to the intended recipient
and may also be privileged. If you are not the intended recipient please
delete it from your system and notify Thales Underwater Systems on +44 1963
370 551. You should not copy it or use it for any purpose nor disclose or
distribute its contents to any other person.
