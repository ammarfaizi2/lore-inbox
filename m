Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263083AbVBCPAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbVBCPAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVBCOzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:55:07 -0500
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:28119 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S263626AbVBCOv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:51:27 -0500
Message-ID: <001501c509ff$d4be02e0$8d00150a@dreammac>
From: "Pankaj Agarwal" <pankaj@toughguy.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Linux Net" <linux-net@vger.kernel.org>
Subject: Query - Regarding strange behaviour.
Date: Thu, 3 Feb 2005 20:15:39 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-PopBeforeSMTPSenders: pankaj@pnpexports.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - toughguy.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In my system there's a strange behaviour.... its not allowing me to create 
any file in /usr/bin even as root. Its chmod is set to 755. Its even not 
allowing me to change the chmod value of /usr/bin. The strangest part which 
i felt is ...its shows the owner and group as root when i issue command 
"ls -ld /usr/bin" and not allowing root to create any file or directory 
under /usr/bin and not even allowing to change the chmod value. The error is 
access permission denied... I can change the chmod value of /usr and other 
directories under /usr/...but not of bin....

I need your help/support. kindly let me know what all can i try to resolve 
this problem.

Thanks and Regards,

Pankaj Agarwal 

