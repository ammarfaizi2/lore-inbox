Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUIELPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUIELPN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUIELPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:15:13 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:935 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266273AbUIELPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:15:04 -0400
Date: Sun, 5 Sep 2004 13:13:57 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905111357.GB26560@thundrix.ch>
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <412D9FFA.6030307@hist.no> <20040902230526.GB15505@zero> <41382624.7000701@hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <41382624.7000701@hist.no>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Fri, Sep 03, 2004 at 10:07:00AM +0200, Helge Hafting wrote:
> Moving a file doen't move the associated thumbnail, and then you
> notice something is missing, or don't find the file, or have to wait
> for regeneration when the app notices a file without a tumb.=20
> That could take some time if you moved a directory full of postscript
> files, for example.

That's why the userland file utilities must be aware of the feature..

			    Tonnerre

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOvT0/4bL7ovhw40RAgqKAJ9UCRaE83uw0sG3JRLyfsvM0y7GwQCggYOx
4xK5eU6Fw7RaZd90uhvUyy0=
=SNye
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
