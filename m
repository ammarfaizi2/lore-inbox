Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315572AbSEIAVS>; Wed, 8 May 2002 20:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315573AbSEIAVR>; Wed, 8 May 2002 20:21:17 -0400
Received: from smtp1.home.se ([195.66.35.200]:50485 "EHLO smtp1.home.se")
	by vger.kernel.org with ESMTP id <S315572AbSEIAVR>;
	Wed, 8 May 2002 20:21:17 -0400
Message-ID: <000e01c1f6ef$6c1819e0$0319450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: NULL dereference for nfs-root using 2.4.19-pre8, 2.4.17 is fine
Date: Thu, 9 May 2002 02:21:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been playing around with nfs-root the last
> couple of days, using 2.2.x kernels on the
bootfloppy.
> I only have 16mb ram in the diskless box, so I had to
> compile a kernel with NBD to use for swap. I didnt
get
> this to work with 2.2 kernels, so I tried building
> 2.4.19-pre8. (Which I btw had to patch in nfsroot.c
to
> get compiled, I know this is known though)

2.4.17 works. Havent tried 2.4.18.

 ---
John Bäckstrand



