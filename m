Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUHPJri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUHPJri (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUHPJri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:47:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267494AbUHPJrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:47:36 -0400
Date: Mon, 16 Aug 2004 11:46:22 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: DRM and 2.4 ...
Message-ID: <20040816094622.GA31696@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0408160652350.9944@skynet> <1092640312.2791.6.camel@laptop.fenrus.com> <412081C6.20601@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <412081C6.20601@tungstengraphics.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 16, 2004 at 10:43:34AM +0100, Keith Whitwell wrote:
> 
> If we can manage to support FreeBSD and Linux from one codebase, surely 
> supporting 2.4 and 2.6 isn't too difficult?

It for sure is possible.
However the DRM codebase proves that it's incapable of even doing BSD
support properly (eg without the right abstractions but instead fouling up
the entire codebase to the point of unreadability). That gives me no
confidence the "keep 2.4 support" will not turn out to be at least as
ugly/broken/wrong.


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBIIJtxULwo51rQBIRAmqVAJ9KaVZCj402mDSkgeSiezXLbY5bCwCggowe
BHQj0aPW/mYvSEB1YPY1tkU=
=eLGw
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
