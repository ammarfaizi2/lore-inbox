Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUGLMDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUGLMDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUGLMDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:03:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266725AbUGLMCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:02:08 -0400
Date: Mon, 12 Jul 2004 14:01:27 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712120127.GB16604@devserv.devel.redhat.com>
References: <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de> <20040712102818.GB31013@devserv.devel.redhat.com> <20040712115003.GV3933@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20040712115003.GV3933@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 12, 2004 at 01:50:03PM +0200, Lars Marowsky-Bree wrote:
> 
> True enough, but I'm somewhat unhappy with this still. So whenever we
> have something like that we need to move it into the kernel space?
> (pvmove first, and now the clustering etc.) Can't we come up with a way
> to export this flag to user-space?

I'm not convinced that's a good idea, in that it exposes what is basically VM internals 
to userspace, which then would become a set-in-stone interface....

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA8n2WxULwo51rQBIRAlSWAKCOoL9RPngQig28BcilBlNSQ8kOtACgloQC
xBVxSqTsrKjRn2Wlem30G0M=
=ldak
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
