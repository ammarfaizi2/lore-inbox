Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWGJJKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWGJJKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWGJJKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:10:48 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63731 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751327AbWGJJKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:10:47 -0400
Message-ID: <44B2196E.5010302@zurich.ibm.com>
Date: Mon, 10 Jul 2006 11:10:06 +0200
From: dirk husemann <hud@zurich.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060607)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Arjan van de Ven <arjan@infradead.org>, suspend2-devel@lists.suspend2.net,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
References: <20060627133321.GB3019@elf.ucw.cz>	<ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com>	<1152377434.3120.69.camel@laptopd505.fenrus.org> <200607082125.12819.rjw@sisk.pl>
In-Reply-To: <200607082125.12819.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig461B60E06C75ED3D7F219A85"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig461B60E06C75ED3D7F219A85
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Rafael J. Wysocki wrote:
> On Saturday 08 July 2006 18:50, Arjan van de Ven wrote:
>  =20
>> [...]
>> PICK ONE AND MAKE IT GOOD.
>>
>> Bang heads together. Go for beer at OLS. I don't care how, but anythin=
g
>> to prevent the insane thing of having multiple half working
>> implementations.
>>    =20
>
> I think everyone agrees with that.  However, the problem is we already =
have
> two of them and one is out of the tree.  Each of them has its supporter=
s who
> believe their implementation of choice is "better" and want it to becom=
e
> the Only One.=20
hmm...not quite sure that the suspend2 ppl want it to become the only
one...we just want to have a fair playing field; that is, not a
situation where we are being told "my code is in the kernel, i like it
much better, work on my code or go away and play somewhere else" when we
have tried the code in the kernel, have found it to be lacking, and have
an alternative that appears to be working much better.
>  Unfortunately the implementations are not 100% mergeable for
> technical reasons and the out-of-the-tree one is more feature-rich.
>
> Now there seem to be two possible ways to go:
> 1) Drop the implementation that already is in the kernel and replace it=
 with
> the out-of-the-tree one.
> 2) Improve the one that already is in the kernel incrementally, possibl=
y
> merging some code from the out-of-the-tree implementation, so that it's=
 as
> feature-rich as the other one.
>
> Apparently 1) is what Nigel is trying to make happen and 2) is what I'd=
 like
> to do.
>  =20
again, i think, nigel is trying to get (3) accomplished:

3) get the out-of-the-tree code merged into the kernel and let
users/developers/distros decide.


    cheers,
    dirk


--=20
Dr Dirk Husemann, Pervasive Computing, IBM Research, Zurich Research Lab
	hud@zurich.ibm.com --- http://www.zurich.ibm.com/~hud/
       PGP key: http://www.zurich.ibm.com/~hud/contact/PGP
  PGP Fingerprint: 983C 48E7 0A78 A313 401C  C4AD 3C0A 278E 6431 A149
	     Email only authentic if signed with PGP key.

Appended to this email is an electronic signature attachment. You can
ignore it if your email program does not know how to verify such a
signature. If you'd like to learn more about this topic, www.gnupg.org
is a good starting point.



--------------enig461B60E06C75ED3D7F219A85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEshluPAonjmQxoUkRAqJ9AKCgkyIy+87zJrky5vtirGBndpOjiACfbXOj
IdBLepxFeVhTdBN8RUIHanM=
=p0Zg
-----END PGP SIGNATURE-----

--------------enig461B60E06C75ED3D7F219A85--
