Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbSIXWBO>; Tue, 24 Sep 2002 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSIXWBO>; Tue, 24 Sep 2002 18:01:14 -0400
Received: from mta04ps.bigpond.com ([144.135.25.136]:28914 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261834AbSIXWBN>; Tue, 24 Sep 2002 18:01:13 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Michael D. Crawford" <crawford@goingware.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Conserving memory for an embedded application
Date: Wed, 25 Sep 2002 07:59:45 +1000
User-Agent: KMail/1.4.5
References: <3D91413C.1050603@goingware.com>
In-Reply-To: <3D91413C.1050603@goingware.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209250759.45445.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 25 Sep 2002 14:53, Michael D. Crawford wrote:
> One question I have is whether it is possible to burn an uncompressed image
> of the kernel into flash, and then boot the kernel in-place, so that it is
> not copied to RAM when it runs.  Of course the kernel would need RAM for
> its data structures and user programs, but it would seem to me I should be
> able to run the kernel without making a RAM copy.
The uclinux guys have eXecute In Place  - google search for uclinux and XIP 
will produce a stack of hits - here's one:
http://www.snapgear.com/tb20010618.html

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Aust. Tickets booked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kOBRW6pHgIdAuOMRAvEKAKCdutujZNT2tBk8gxkjkVz1ColD0wCdGZr+
75U01oH+2G4UWiJSk59/CBU=
=SJGg
-----END PGP SIGNATURE-----

