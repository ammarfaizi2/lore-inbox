Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269868AbRHIWnC>; Thu, 9 Aug 2001 18:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270604AbRHIWmw>; Thu, 9 Aug 2001 18:42:52 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:32012
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S269868AbRHIWmk>; Thu, 9 Aug 2001 18:42:40 -0400
Date: Thu, 09 Aug 2001 18:42:34 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, lvm-devel@sistina.com
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
Message-ID: <532210000.997396954@tiny>
In-Reply-To: <Pine.GSO.4.21.0108091822440.25945-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, August 09, 2001 06:24:46 PM -0400 Alexander Viro <viro@math.psu.edu> wrote:

> Chris, how about doing that after fs/super.c stuff (things that went into
> -ac)?
> 

well, it depends on how soon the fs/super.c stuff goes in ;-)
I'd prefer to provide you with an updated patch for -ac, and get
this into the kernel sooner than later.  It's your call though, including
if you just want to hold off until I've got the -ac patch done.

-chris

