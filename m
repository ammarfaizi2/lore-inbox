Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267758AbUH2L5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267758AbUH2L5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUH2L5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:57:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19862 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267758AbUH2L5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:57:33 -0400
Date: Sun, 29 Aug 2004 13:57:11 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [bk pull] DRM tree - stop i830/i915 in kernel
Message-ID: <20040829115711.GC23428@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0408291220330.11976@skynet> <1093779603.2792.19.camel@laptop.fenrus.com> <28148.203.122.194.204.1093780542.squirrel@www.csn.ul.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <28148.203.122.194.204.1093780542.squirrel@www.csn.ul.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 29, 2004 at 12:55:42PM +0100, Dave Airlie wrote:
> 
> >
> > please don't do this.
> > This makes it not possible for distributions to ship kernels that need
> > to work on both old and new X versions....
> >
> 
> no, it'll stop distributions from shipping kernels with both drivers
> built-in, modular kernels will work fine, X picks the driver to load, if
> people are building in the drivers then I believe they know what they are
> at...
> 
> Having both drivers built-in is obviously broken and actually doesn't work
> at all (someone reported it in an Xorg bug...)

ok fair enough; ignore my objection

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBMcSXxULwo51rQBIRAnKwAKCHO3G3GLEDWadiSAOD1kNkr5RjmwCdGOtY
41cjeJS1xmZPIW64qvvxIp4=
=anTo
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
