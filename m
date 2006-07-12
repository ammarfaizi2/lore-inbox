Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWGLAnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWGLAnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWGLAnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:43:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:62835 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932320AbWGLAnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:43:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MD0yUuollH4tkaPOA4gqgFMbbDdKFZ72QI+Ng93jZHPqiZ1uqqKnwFuS4y6flFNRViOSRld+BrNB8nGcd5rwO/mUuNHw65yEm7rqT32ENCSI5ZI2ojVg8E5SEiRi+CgP9seOkOzpXTgr+3q9RZjK7aIzlqJ94EVOdsU2x1iYNNI=
Date: Tue, 11 Jul 2006 20:42:12 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net
Subject: Re: Will there be Intel Wireless 3945ABG support?
Message-ID: <20060712004212.GA26712@phoenix>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
	Alon Bar-Lev <alon.barlev@gmail.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	"John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net
References: <1152635563.4f13f77cjsmidt@byu.edu> <20060711171238.GA26186@tuxdriver.com> <200607111909.22972.s0348365@sms.ed.ac.uk> <44B3ED29.4040801@gmail.com> <20060711201615.GB11871@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20060711201615.GB11871@Marvin.DL8BCU.ampr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On July 11 at 16:16 EDT, Thorsten Kranzkowski hastily scribbled:
> On Tue, Jul 11, 2006 at 09:25:45PM +0300, Alon Bar-Lev wrote:
> >=20
> > Also there is no good reason why supplying this daemon as closed source=
=2E..=20
> > All they
> > wish is people don't mess with their frequencies, and sooner or later=
=20
> > someone will...
>=20
> Using interesting frequencies or output power would be fun for
> radio amateurs (like me). 2.4GHz is one of our playgrounds after all :-)

Hear, hear!

> Just because Joe Average isn't allowed to use such features doesn't
> mean that there aren't any legitimate users for it.
> =20
> Preventing the accidental use of unauthorized features would be enough,=
=20
> I think (warnings that force you to look up the manual to find out the
> correct --force option or similar)
> I expect developers to be sensible enough to only offer 'public legal'
> values in the default options list.

Frankly, I think Intel is misinterpreting how strict the FCC is being
(or maybe the FCC is being too strict).  I would interpret their
mandates as meaning that, as purchased, equipment can't transmit on
unauthorized frequencies, and that it's not "user-modifiable".  User
modification doesn't include things like opening the case of a toy
walkie-talkie up and swapping out a crystal, nor does it include things
like opening up the firmware or driver for something and messing with
it.

Frankly, I'm annoyed that, if Intel understood the full extent of the
problem, that they didn't take a better approach and simply give the
card a set of legal values.  It doesn't need to understand the
subtleties of what they mean.  It just needs to know frequencies 1, 2,
and 3 are okay, but not 4, 5, and 6, and that the max power is xx dBm.

OTOH, I'd love to get one of these cards and play with it.  I'd love a
WiFi card that can run up to 5 or 10 watts.  (1500 is a little much, and
my laptop's battery can't supply it :-)

-- Thomas Tuttle

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEtEVk/UG6u69REsYRAlhNAJ95mnDGYvFdrF3i0j6ABndmaTnE3wCfaMFl
xPEclDC4U9/UdhyR/ofD2e8=
=ik5q
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
