Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRB0XOP>; Tue, 27 Feb 2001 18:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129899AbRB0XOG>; Tue, 27 Feb 2001 18:14:06 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:21007 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129884AbRB0XNy>; Tue, 27 Feb 2001 18:13:54 -0500
Date: Wed, 28 Feb 2001 00:12:21 +0100
From: Kurt Garloff <garloff@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: modutils 2.4.3 is available
Message-ID: <20010228001221.P21238@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Keith Owens <kaos@ocs.com.au>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3A9A2B3B.421AE7E8@hanse.com> <22995.983227286@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22995.983227286@ocs3.ocs-net>; from kaos@ocs.com.au on Tue, Feb 27, 2001 at 09:41:26AM +1100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2001 at 09:41:26AM +1100, Keith Owens wrote:
> On Mon, 26 Feb 2001 11:08:59 +0100,=20
> Stefan Smietanowski <stefan@hanse.com> wrote:
> >Keith Owens wrote
> >> modutils-2.4.3.tar.gz           Source tarball, includes RPM spec file
> >
> >IIRC 2.4.2 was 2.4 only, and was released under protest, is it the same
> >for 2.4.3?
>=20
> modutils 2.4 will work on kernel 2.0 and libc 5, one of the changes in
> 2.4.3 is for libc5 support.  The protest period has expired.

To clearify: The incompatibility only affects the hotplug kernel device
tables ...=20
As there was no support amongst USB crowds for adding a version info for the
table formats, the modutils-2.4.2 could not provide support for per 2.4.0
kernel hotplug device tables. Nor can 2.4.3. The rest of the functionality
is unaffected.
Keith, correct me if I misunderstood ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6nDRUxmLh6hyYd04RAs2/AKCn8eobQyqZ9718Gz8CLpSVFNlQewCfQfyg
tZlKqME/cUYSZVrrLKbuCJg=
=rR/t
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--
