Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUBWXvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUBWXvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:51:25 -0500
Received: from ponzi.oit.umass.edu ([128.119.166.18]:47018 "EHLO
	ponzi.oit.umass.edu") by vger.kernel.org with ESMTP id S262076AbUBWXvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:51:24 -0500
Date: Mon, 23 Feb 2004 18:51:16 -0500
From: jabbera@student.umass.edu
Subject: libata/iswraid DMA Timeout
To: linux-kernel@vger.kernel.org
Message-id: <1077580276.403a91f4094fe@mail-www4.oit.umass.edu>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2
X-Originating-IP: 24.60.191.209
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry never posted to this list so bear with me. 
I am currently using kernel version 2.4.25 i386 with libata and iswraid. 
Note: iswraid is for 2.4.22, but it applied to 2.4.25 without issue. 
 
I am not sure which patch this problem is in relation to, but here is the 
information. 
 
I was using a php script to move a bunch of my files around the file system 
when my system locks up and I see: 
ata1: DMA timeout, stat 0x21 
ATA: abnormal status 0x59 on port 0xC407 
 
I try to do an emegency sync but I fails, and I am forced to reboot. 
This problem is reproducable. If any additional information is needed please 
email me as I am not a member of the mailing list. 
 
Thanks. 
