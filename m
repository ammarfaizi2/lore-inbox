Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbSL2RDv>; Sun, 29 Dec 2002 12:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSL2RDv>; Sun, 29 Dec 2002 12:03:51 -0500
Received: from tag.witbe.net ([81.88.96.48]:26384 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S266528AbSL2RDr>;
	Sun, 29 Dec 2002 12:03:47 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Andrew Walrond'" <andrew@walrond.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.53] So sloowwwww......
Date: Sun, 29 Dec 2002 18:12:07 +0100
Message-ID: <00bd01c2af5d$6b0404c0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3E0F2954.1040502@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> 
> Ouch; that is slow. What partition type are you building from ?
> 
This is an ext3 partition, and a SCSI disk :
4 [18:10] rol@donald:/kernels> df .
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1             10320888    753828   9042724   8% /kernels

Do you think I should try on some other ?
The problem is that the system is *globally* slow, and compiling
the kernel is just a way to prove it. Starting KDE has become a real
pain (so slow screen detects no more video and enter Energy Saving
mode before reactivating and switching to Graphic mode).

Regards,
Paul

