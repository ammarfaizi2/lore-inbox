Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288006AbSAHMjX>; Tue, 8 Jan 2002 07:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288005AbSAHMjP>; Tue, 8 Jan 2002 07:39:15 -0500
Received: from [203.124.139.197] ([203.124.139.197]:5637 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP
	id <S288001AbSAHMi7>; Tue, 8 Jan 2002 07:38:59 -0500
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "Chandrasekhar" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with network
Date: Tue, 8 Jan 2002 18:23:48 +0530
Message-ID: <NFBBJJFKOKJEMFAEIPPJCEAHCBAA.chandrasekhar.nagaraj@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,


We are facing a problem regarding the network communication.
System: Linux Kernel 2.4.7 with rmk2 and np1 patch on Assabet board.
Problem: After setting all the required and necessary network parameters and
running the utlility ifconfig we get the following error message
SIOCSIFHWADDR: Device or resource busy
But the IP Address, Netmask and Broadcast addressess are properly set.
After this if we run ftp we get the following error message
ftp: NETDEV WATCHDOG: eth0 timeout
We tried increasing the timeout period but in vain.

Pls Suggest

Regards
Chandrasekhar


