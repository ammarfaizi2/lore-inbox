Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315238AbSEDXCr>; Sat, 4 May 2002 19:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSEDXCq>; Sat, 4 May 2002 19:02:46 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:22066 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S315238AbSEDXCp>;
	Sat, 4 May 2002 19:02:45 -0400
Message-ID: <001b01c1f3bf$c3b97960$0201a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.13] initrd broken again
Date: Sun, 5 May 2002 01:02:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initrd was working from 2.5.(9,10?) till 2.5.12-dj. But 2.5.13 (even -dj1)
is doing exactly the same thing as earlier kernels (loading initrd, then
freeing initrd memory and panic: cannot mount root). I've checked
patch-2.5.13.gz but i cannot see anything that could make this dumb issue.
Waiting for reply as soon as it's possible, I have to test one more issue
that could probably happen on 2.5.13 :)
WK


