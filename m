Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293034AbSB1AfM>; Wed, 27 Feb 2002 19:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293105AbSB1Aef>; Wed, 27 Feb 2002 19:34:35 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:2688
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S293034AbSB1Ad6>; Wed, 27 Feb 2002 19:33:58 -0500
Date: Wed, 27 Feb 2002 16:33:41 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2 oops
In-Reply-To: <Pine.LNX.4.10.10202271301180.8641-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.33.0202271633120.11102-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 27 Feb 2002, James Simmons wrote:

> > Okay folks. Here is another patch to fix the oops. It is against a
> > http://www.transvirtual.com/~jsimmons/console/console_8.diff
>
> Okay. This time I believe I see what caused the oops. Give it a try again.

Yes, that cures both the oopses when mingetty runs and the oops when X
starts up.

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fXrpsYXoezDwaVARAnAbAJ9FBEkSADZvaKQBjqB5d4UkUhc7qACePtLZ
VTP8NkCNQhTCGtyObrM6MTM=
=qbAS
-----END PGP SIGNATURE-----

