Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281547AbRKMHLX>; Tue, 13 Nov 2001 02:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281546AbRKMHLO>; Tue, 13 Nov 2001 02:11:14 -0500
Received: from [203.197.249.146] ([203.197.249.146]:23947 "EHLO
	indica.wipsys.stph.net") by vger.kernel.org with ESMTP
	id <S281489AbRKMHK5>; Tue, 13 Nov 2001 02:10:57 -0500
Message-ID: <3BF11605.335EBC76@wipro.com>
Date: Tue, 13 Nov 2001 18:15:57 +0530
From: "s.srinivas" <srinivas.surabhi@wipro.com>
Reply-To: srinivas.surabhi@wipro.com
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.5-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: % more space reqd. when dd is used? 
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi all,

I have two  physical harddisks /dev/hda1 and /hdb

1) i want to copy drive (take backup) to a file ( in /hdb)using dd.
So how much space( in terms percentage)more is required in /hdb
for it to be copied successfully.

2) After copying using dd if=/dev/hda1 of=/hdb/backup

how to retrive it back again in terms of directories and sub-directories
and files.

thank u all

regards
vasu



--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

The Information contained and transmitted by this E-MAIL is proprietary to Wipro and/or its Customer and is intended 
for use only by the individual or entity to which it is addressed, and may contain information that is privileged,
confidential or exempt from disclosure under applicable law. If this is a forwarded message, the content of this
E-MAIL may not have been sent with the authority of the Company. If you are not the intended recipient, an agent
of the intended recipient or a  person responsible for delivering the information to the named recipient,  you are
notified that any use, distribution, transmission, printing, copying or dissemination of this information in any way
or in any manner is strictly prohibited. If you have received this communication in error, please delete this mail &
notify us immediately at mailadmin@wipro.com

--------------InterScan_NT_MIME_Boundary--
