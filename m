Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSEIOGg>; Thu, 9 May 2002 10:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312987AbSEIOGf>; Thu, 9 May 2002 10:06:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:14283 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312938AbSEIOGf>;
	Thu, 9 May 2002 10:06:35 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 9 May 2002 16:06:32 +0200 (MEST)
Message-Id: <UTC200205091406.g49E6W018636.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] hdreg.h
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Thu, May 09, 2002 at 03:48:32PM +0200, Andries.Brouwer@cwi.nl wrote:
    > No, fdisk, cfdisk, sfdisk do not use HDIO_GETGEO_BIG.
    > And indeed, the ioctl is completely meaningless.

    In many current distributions (e.g. from Red Hat, Mandrake and Caldera)
    they do.

Yes, distributions are known to introduce buggy patches.

Moreover, distributions are known to copy each others bugs.
Sometimes I tell one distribution that a patch is buggy,
and they revert their patch, but some months later they
have it again, copied from some other distribution.
Even bad "segmentation fault" bugs are copied.

But for 2.5 this is not important. Distributions have time
to fix stuff before 2.6.

Andries
