Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274868AbRIZUiX>; Wed, 26 Sep 2001 16:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275038AbRIZUiE>; Wed, 26 Sep 2001 16:38:04 -0400
Received: from arioch.Stanford.EDU ([128.12.177.45]:51472 "HELO
	apogee.ifokr.org") by vger.kernel.org with SMTP id <S274868AbRIZUiB>;
	Wed, 26 Sep 2001 16:38:01 -0400
Date: Wed, 26 Sep 2001 13:38:20 -0700
From: Brian Hatch <linux-security-module@ifokr.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010926133820.V598@ifokr.org>
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com> <20010925202417.A16558@kroah.com> <3BB229D1.10401@wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="87MiR7gHvrw39A9h"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB229D1.10401@wirex.com>; from crispin@wirex.com on Wed, Sep 26, 2001 at 12:17:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--87MiR7gHvrw39A9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Crispin wrote:

> We have a Schrodinger's Cat problem of whether the courts will=20
> eventually rule that modules are derivative works of the kernel. There=20
> are two cases here.  Either:
>=20
>     * Binary modules are permitted by the kernel's GPL:  if this is the
>       case, then Greg's comment is invalid, and misleading.
>     * Binary modules are not permitted by the kernel's GPL: if this is
>       the case, then Greg's comment is redundant, and just marking the
>       file "GPL" is sufficient.

This is the most concise explanation of the problem so far.

I don't like binary security modules, and I won't use them nor
write them, because that's my desicion to make.  Whether they
are legal or not is not.  It's all there in the GPL for well
paid lawyers to determine.  It doesn't seem that there's any
benefit to adding to the existing licensing terms -- it all
boils down to which of the two above cases is true.

> IMHO, in neither case is the special language appropriate. This file is=
=20
> GPL'd, and we should stop playing lawyer by trying to interpret what=20
> that means.
>
> If you (Greg, Alan) are confident that your interpretation of the GPL is=
=20
> correct, then just marking the files as GPL should be sufficient. What=20
> purpose is served by saying anything else?

Ding.

I wouldn't mind any 'We heartily suggest/prefer' wording, just let's
not get into anything legal or restrictive or the license could become
internally contradictory and make it more difficult to prosecute
GPL infractions.  (Where there are two different ideas in this
group about what constitutes an infraction...)

I always assumed that the LSM was to be treated no differently than
existing modules -- LKMs may be close source.  It was never said
otherwise anywhere when this project was formed.  Changing (ahem,
clarifying) it at this stage of the game is a bad thing.

Had I been able to contribute actual code to this project
(the days never are long enough, are they) I'd have more
of a direct say.  Taking an approach like 'oh, X of Y
developers say one thing, now that we asked' is not a fair
way to make desicions.  Though many on this list have not
contributed code, they have made comments and suggestions
which were used by the primary coders.  Perhaps we should
take a grand survey of everyone and see what they think,
since they all had some input, if not output, into the
code as it stands?  No, that's even worse.

The LSM code is GPLd.  That was a stated requirement from day one.
Nothing else was.  Leave the interpretation of binary module
acceptibility/nonacceptibility to the GPL and the lawyers, that's
not our job.





--
Brian Hatch                e ^ (i*pi) =3D -1
   Systems and
   Security Engineer
www.hackinglinuxexposed.com

Every message PGP signed

--87MiR7gHvrw39A9h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuyPLwACgkQbHrkO1vvTcq2WACg3Ovu21zngTVWwvQNftKlP3/8
+V4An0+W7uE4ILi3JXMvl8HPs7bqYxXe
=m+D2
-----END PGP SIGNATURE-----

--87MiR7gHvrw39A9h--
