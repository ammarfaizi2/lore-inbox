Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUFIOVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUFIOVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFIOVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:21:54 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:41125 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266139AbUFIOVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:21:42 -0400
Date: Wed, 9 Jun 2004 16:21:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
Message-ID: <20040609142141.GT20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040607141353.GK21794@wiggy.net> <20040608210846.GA5216@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RxBYAwKLDxPbmc5c"
Content-Disposition: inline
In-Reply-To: <20040608210846.GA5216@mars.ravnborg.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RxBYAwKLDxPbmc5c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-08 23:08:46 +0200, Sam Ravnborg <sam@ravnborg.org>
wrote in message <20040608210846.GA5216@mars.ravnborg.org>:
> On Mon, Jun 07, 2004 at 04:13:53PM +0200, Wichert Akkerman wrote:
> I'm in progress of doing some infrastructure work to better support build=
ing
> different packages. I have requests for .tar.gz, tar.gz2 as well
> as deb.

(Being a Debian user...) I really *love* to see a .tar.{gz,bz2} target.
For my in-house use (as well in in the company I work for) we do have a
script to basically install modules (+ vmlinuz + vmlinux + .config +
System.map), adding some identifier to the filenames (of the last four
files mentioned) and preparing a .tar.gz from that.

For my private use, my version of the script also handles some non-ia32
archs :)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--RxBYAwKLDxPbmc5c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxxz1Hb1edYOZ4bsRAj9KAJ9BNOKhtFVjSbeTmEfuiEl0Dt6oLACfT0Mh
DnC/ds+zbV7FrqA0rGzbBJg=
=laO7
-----END PGP SIGNATURE-----

--RxBYAwKLDxPbmc5c--
