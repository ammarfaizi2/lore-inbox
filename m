Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293634AbSCKIZp>; Mon, 11 Mar 2002 03:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293638AbSCKIZf>; Mon, 11 Mar 2002 03:25:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51722 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293634AbSCKIZX>;
	Mon, 11 Mar 2002 03:25:23 -0500
Date: Mon, 11 Mar 2002 09:25:13 +0100
From: Jens Axboe <axboe@suse.de>
To: kreuzritter2000@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: UDF Write Support with CD-RW and CD-R Devices ?
Message-ID: <20020311082513.GA31108@suse.de>
In-Reply-To: <21051.1015437480@www39.gmx.net> <20020306185037.IYN23259.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020306185037.IYN23259.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06 2002, Skip Ford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> kreuzritter2000@gmx.de wrote:
> > Hello,
> > 
> > I want to use UDF with my CD-RW Device
> > but write support is not supported at the moment.
> > 
> > So I want to ask what is the status about this Topic at the moment?
> > Is someone working on this?
> 
> Peter Osterlund has been maintaining Jens' packet writing code and has
> written an updated version for 2.5.  It works for many drives.
> 
> You can find the patches here:
> http://w1.894.telia.com/~u89404340/patches/packet/
> 
> I have no idea when it will be included...Jens would have to answer
> that.

I plan for 2.5 integration in the not-so distant future.

-- 
Jens Axboe

