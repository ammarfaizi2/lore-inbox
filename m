Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310126AbSCFSvn>; Wed, 6 Mar 2002 13:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310127AbSCFSvd>; Wed, 6 Mar 2002 13:51:33 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:60845 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S310126AbSCFSvV>; Wed, 6 Mar 2002 13:51:21 -0500
Date: Wed, 6 Mar 2002 13:50:30 -0500
From: Skip Ford <skip.ford@verizon.net>
To: kreuzritter2000@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDF Write Support with CD-RW and CD-R Devices ?
Mail-Followup-To: kreuzritter2000@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <21051.1015437480@www39.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <21051.1015437480@www39.gmx.net>; from kreuzritter2000@gmx.de on Wed, Mar 06, 2002 at 06:58:00PM +0100
Message-Id: <20020306185037.IYN23259.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

kreuzritter2000@gmx.de wrote:
> Hello,
> 
> I want to use UDF with my CD-RW Device
> but write support is not supported at the moment.
> 
> So I want to ask what is the status about this Topic at the moment?
> Is someone working on this?

Peter Osterlund has been maintaining Jens' packet writing code and has
written an updated version for 2.5.  It works for many drives.

You can find the patches here:
http://w1.894.telia.com/~u89404340/patches/packet/

I have no idea when it will be included...Jens would have to answer
that.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjyGZOQACgkQBMKxVH7d2wodiwCgiqeTZjwF+DYK/Ga5bJZlUc4F
74IAmwasNUo10pClWDveF8ZU/dMCnVrR
=2NZs
-----END PGP SIGNATURE-----
