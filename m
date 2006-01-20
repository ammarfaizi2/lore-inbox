Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWATIZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWATIZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWATIZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:25:52 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:35245 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750729AbWATIZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:25:51 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: [SARCASM] Re: [2.6 patch] the scheduled removal of the obsolete raw driver
Date: Fri, 20 Jan 2006 09:24:50 +0100
User-Agent: KMail/1.7.2
Cc: Adrian Bunk <bunk@stusta.de>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
References: <20060119030251.GG19398@stusta.de> <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com> <20060119165832.GS19398@stusta.de>
In-Reply-To: <20060119165832.GS19398@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1736195.naqfpKYS10";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601200924.56608.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1736195.naqfpKYS10
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 19 January 2006 17:58, Adrian Bunk wrote:
> On Thu, Jan 19, 2006 at 08:44:31AM -0800, Badari Pulavarty wrote:
> >...
> > But again, its really useful to have raw driver to do simple "dd" tests
> > to test raw performance for disks (for comparing with filesystems, block
> > devices etc..). Without that, we need to add option to "dd" for
> > O_DIRECT.
>=20
> The oflag=3Ddirect option was added to GNU coreutils in version 5.3.0.

And Debian Sarge is still at 5.2.1.=20
(Not to obsolete iproute and ipsec-tools versions)

Ok, Debian Sarge is scheduled for removal from my
system.

What:   Debian Sarge
When:   2006-02-04
=46iles:  ssh root@bertha -c "find /bin /sbin /usr /lib"
       =20
Why:    Its maintained to slow for a number of years
        and can be replaced by Kubuntu or Ubuntu.
	Having a recent kernel (with more bugs fixed)
	and trying to use it, becomes harder and harder.

Who:    $FROM


--nextPart1736195.naqfpKYS10
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD0J5YU56oYWuOrkARAs/2AJ9hOEXJy+FhmWYPC4JwJv2O+AvO2wCdE1nO
K8oK9EmxOrbruMyjxzNh40M=
=smt4
-----END PGP SIGNATURE-----

--nextPart1736195.naqfpKYS10--
