Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291213AbSBGSab>; Thu, 7 Feb 2002 13:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291191AbSBGS3T>; Thu, 7 Feb 2002 13:29:19 -0500
Received: from 64-219-97-203.reverse.aitinternet.com ([64.219.97.203]:17795
	"EHLO genesis.realtate.com") by vger.kernel.org with ESMTP
	id <S291197AbSBGS2m>; Thu, 7 Feb 2002 13:28:42 -0500
Message-ID: <001101c1b005$359421b0$f97ba8c0@oemcomputer>
From: "Rick" <lindev@realtate.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel/module issue
Date: Thu, 7 Feb 2002 12:28:14 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernel 2.4.17. I've recompiled the kernel and now I'm getting a
weird error message that I've not seen before - well...not a module I've
seen.

Feb  7 01:25:19 genesis modprobe: modprobe: Can't locate module binfmt-e0ff
Feb  7 01:26:10 genesis last message repeated 4 times
Feb  7 01:26:41 genesis last message repeated 5 times
Feb  7 01:28:50 genesis modprobe: modprobe: Can't locate module binfmt-e0ff
Feb  7 01:29:54 genesis last message repeated 4 times
Feb  7 01:30:59 genesis last message repeated 8 times
Feb  7 01:30:59 genesis modprobe: modprobe: Can't locate module binfmt-e0ff
Feb  7 01:44:49 genesis modprobe: modprobe: Can't locate module binfmt-e0ff
Feb  7 01:44:52 genesis last message repeated 3 times
Feb  7 01:47:47 genesis modprobe: modprobe: Can't locate module binfmt-e0ff

Can anyone tell me what binfmt-e0ff is used for? What it does? and is it
serious?

Please CC me any answers or comments. I'm not yet on the list.

