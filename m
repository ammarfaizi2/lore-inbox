Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUHDVXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUHDVXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUHDVXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:23:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267435AbUHDVXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:23:17 -0400
Date: Wed, 4 Aug 2004 23:22:29 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlock-as-user for 2.6.8-rc2-mm2
Message-ID: <20040804212228.GA23054@devserv.devel.redhat.com>
References: <20040804140102.O1924@build.pdx.osdl.net> <Pine.LNX.4.44.0408041705130.9630-100000@dhcp83-102.boston.redhat.com> <20040804142401.52b7161e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20040804142401.52b7161e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 04, 2004 at 02:24:01PM -0700, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> >
> > Andrew, could you please apply Chris's patch in addition
> > to mine ?
> 
> OK, but I don't have any confidence that anyone will be testing it.
> 
> Can you think of some way in which we can artificially tweak the patch
> for testing so that its new features are getting some exercise?

gpg uses mlock (well it tries to) which is why the fedora patch has a 4Kb
default ;)


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBEVOUxULwo51rQBIRAszkAJwJ3UQQuzS9uNANnT8nuUBXHdpWqwCeMtBw
EOIVDi2HUR1JwydQLz+sLHQ=
=2U75
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
