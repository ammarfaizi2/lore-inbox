Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSCSIfW>; Tue, 19 Mar 2002 03:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310469AbSCSIfN>; Tue, 19 Mar 2002 03:35:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:34567 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S310468AbSCSIfD>; Tue, 19 Mar 2002 03:35:03 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Bitkeeper licence issues
Date: 19 Mar 2002 08:21:00 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna9dt7c.nqc.kraxel@bytesex.org>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de> <20020318180233.D10086@work.bitmover.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1016526060 24397 127.0.0.1 (19 Mar 2002 08:21:00 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  The reason we didn't use shar, Pavel, is that we are shipping a binary.
>  If we used shar that would increase the size of the image that you download
>  and we wanted downloads to be fast.  As it is, I think it's a couple of MB.

I don't like the binary installer that much too.

Why don't you ship a tarball with a install script within the tarball
(like vmware does for example)?  That would make downloads even smaller
for people with bzip2 installed as you can easily provide both .tar.gz
and .tar.bz2 ...

  Gerd

-- 
#include </dev/tty>
