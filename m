Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313556AbSDUQjP>; Sun, 21 Apr 2002 12:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSDUQjO>; Sun, 21 Apr 2002 12:39:14 -0400
Received: from flaxian.hitnet.RWTH-Aachen.DE ([137.226.181.79]:39952 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S313556AbSDUQjN>;
	Sun, 21 Apr 2002 12:39:13 -0400
Date: Sun, 21 Apr 2002 18:39:10 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3: i_blocks is xx, should be yy
Message-ID: <20020421163910.GA30181@gondor.com>
In-Reply-To: <20020421162915.GA28414@gondor.com> <20020421173535.C20834@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 05:35:35PM +0100, Russell King wrote:
> Did the filesystem run out of free blocks at any point?
> If so, the following could explain it:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101778284030725&w=2

Ah, yes, thanks - i missed this mail when I searched the archives.
This mail describes exactly what I have seen.

Jan

