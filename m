Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316352AbSEOGjg>; Wed, 15 May 2002 02:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316353AbSEOGjf>; Wed, 15 May 2002 02:39:35 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:35047 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S316352AbSEOGjf>; Wed, 15 May 2002 02:39:35 -0400
From: "Ashok Raj" <ashokr2@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Address space limits in IA32 linux
Date: Tue, 14 May 2002 11:02:20 -0700
Message-ID: <PPENJLMFIMGBGDDHEPBBEEJHDAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

what is the maximum addressible virtual address in a IA32 Linux system (4G?)

typically since Database requires a larger address space, does linux kernel
has any config to limit this space for kernel, so that the user process has
more address to play with?

thanks
ashok

