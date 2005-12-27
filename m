Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVL0HBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVL0HBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 02:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVL0HBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 02:01:13 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:18219 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932252AbVL0HBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 02:01:12 -0500
Date: Tue, 27 Dec 2005 02:19:56 -0500
From: Mitchell Laks <mlaks@verizon.net>
Subject: HPT372N   Re: hpt366 driver oops or panic with HighPoint RocketRAID
 1520SATA
To: linux-kernel@vger.kernel.org
Message-id: <200512270219.56956.mlaks@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
 I recently bought 
Highpoint RocketRaid 1520 pci - dual channel -  sata cards - chip is HPT372N -   
to use as simple block devices for linux software raid purposes.   I thought 
they were supported on Linux, because of highpoint web site and my previous 
experience with highpoint pata controllers was ok.
 
 However I get the same kernel OOPS reported by Johan Palmqvist on Mon Nov 07 
2005 with the latest stable kernel 2.6.14.4 .
 
 I also see a posting from Mar 17 2003 by Henning Schroeder reporting success 
with the highpoint driver hpt3xx-opensource-v131.tgz. 
 
 I tried to compile the hpt3xx-opensource-v2.0.tgz against latest stable 
kernel 2.6.14.4. After minor corrections   I have failure to compile their 
driver due to  scsi_cmnd structure "has no member abort_reason".  Has their 
been a change in scsi subsystem? 
 
 Which kernel can I use? Any advice? Sorry to interrupt your amazing work with 
my question. I am off list. I will read list but cc is appreciated. 
 
 Thanks Gurus!
 
 Mitchell Laks
  
 
