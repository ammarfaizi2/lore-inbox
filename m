Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSL2Sby>; Sun, 29 Dec 2002 13:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSL2Sbx>; Sun, 29 Dec 2002 13:31:53 -0500
Received: from tag.witbe.net ([81.88.96.48]:33042 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S261337AbSL2Sbx>;
	Sun, 29 Dec 2002 13:31:53 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'zhaoway'" <zw@netspeed-tech.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Kernel configuration in kernel, kernel 2.5.53
Date: Sun, 29 Dec 2002 19:40:09 +0100
Message-ID: <00c501c2af69$b79cab00$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3E0F3C6F.3090701@netspeed-tech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You could write a simple script to install a kernel image and 
> install the .config under /boot as well. Guess that solves your 
> problem better.
> 
Yes, but this still makes the configuration something external to
the kernel, thus it is still possible to have a mismatch between
the kernel and this file, and this is what I'm trying to avoid :-)

Regards,
Paul

