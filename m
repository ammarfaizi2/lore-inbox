Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUIFO16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUIFO16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUIFO15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:27:57 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:11434 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268040AbUIFO1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:27:52 -0400
Date: Mon, 6 Sep 2004 16:26:42 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Erik Hensema <erik@hensema.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040906142642.GB29886@thundrix.ch>
References: <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <14260000.1094149320@flay> <1094154744.12730.64.camel@voyager.localdomain> <slrncjf11e.6pa.erik@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <slrncjf11e.6pa.erik@bender.home.hensema.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Sep 02, 2004 at 08:35:58PM +0000, Erik Hensema wrote:
> In this case it's hard to imagine what advantages a multistream file
> will bring, simply  because we aren't used to  working with them. Or
> maybe there  aren't any advantages at  all. Point is:  we don't know
> yet. Maybe  we have to  toy with the  idea for some years  before we
> really learn why multistream files are so great.

Thus I recommend doing the same thing everything does to get his stuff
implemented.

How did User Mode Linux get accepted into the kernel?

In the beginning,  people couldn't imagine any advantage  of it. Then,
someone  started coding  it and  provided patches.   People  tried it,
improved it (important!  It got  to work on many platforms while being
out of the main tree!) and some day we noticed that it was really cool
for kernel hacking and virtualization.=20

So when it approached a mature level where we finally saw it was cool,
it went into the mainline kernel, where it is now.

For multistream files, what is that development cycle going to be? Get
the idea, flame, flame, flame... ?

Code talks, bullshit walks.

			    Tonnerre

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPHOi/4bL7ovhw40RApTnAKC3gaoI1OWpHnHkuJMe8fHb3eKKAQCfen1x
rHkFUQF+M2+xKmKMuYBqhtw=
=cJaA
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
