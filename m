Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWFMJik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWFMJik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 05:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWFMJik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 05:38:40 -0400
Received: from wehq.winbond.com.tw ([202.39.229.15]:15776 "EHLO
	wehq.winbond.com.tw") by vger.kernel.org with ESMTP
	id S1750836AbWFMJik convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 05:38:40 -0400
thread-index: AcaOzP76pQvDt4NERIuh4YQ+Sm52ew==
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.326
Message-ID: <448E875A.40805@winbond.com>
Date: Tue, 13 Jun 2006 17:37:30 +0800
From: "dezheng shen" <dzshen@winbond.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "PI14 SJIN" <SJin@winbond.com>
Subject: [Winbond] flash memory reader SCSI device drivers
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 13 Jun 2006 09:37:31.0048 (UTC) FILETIME=[FDE0D280:01C68ECC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear all:
  We first posted this message to linux-scsi list but it seems no one is 
monitoring that list at this moment. We tried twice but didn't get any 
reply yet. So, we decided to post it again here. If this is not the 
right place, could someone lead us to the right one? Thank you.


 We would like to contribute our flash memory device drivers to Linux 
community and would like to post to a public list for review first.

 Since our drivers are implemented using SCSI subsystem so that our 
driver sources should go to ./drivers/scsi. If possible, can we create a 
subdirectory in ./drivers/scsi named "winbond" because we have drivers 
for SD/MMC/MS/MSPRO/xD/SM for various Winbond chips. It might be easier 
for us to maintain our own subdirectory.

 This is the first we send this request to this mailing list and we are 
not sure this is the right way to do. If any of you is interested in 
reviewing our sources for Memory Stick driver for Winbond w518 chip, 
please let me know so that we can post our sources.

thank you,

dz



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
