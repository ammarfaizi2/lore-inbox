Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbTLFPrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbTLFPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:47:04 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:12200 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S265201AbTLFPq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:46:59 -0500
Subject: Re: Linux 2.4 future
From: Max Valdez <maxvalde@fis.unam.mx>
To: John Jasen <jjasen@realityfailure.org>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312051021300.1469-100000@bushido>
References: <Pine.LNX.4.44.0312051021300.1469-100000@bushido>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NUrL/aw839rL5hNVsGc2"
Message-Id: <1070725773.2258.51.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 09:49:33 -0600
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NUrL/aw839rL5hNVsGc2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The nices thing is that the evolution from 2.6.0 to 2.6.8 will be very
fast :-), what are the predictions? mine is less than 6 months, we begin
with a nice kernel, not the best, but will finish those 6 months with a
great kernel, really stable, the the release pace will be slower, and we
can start to think on the new shiny unstable 2.7.x kernel :-)

Max
On Fri, 2003-12-05 at 09:33, John Jasen wrote:
> On Wed, 3 Dec 2003, Jan Rychter wrote:
>=20
> > >>>>> "Marcelo" =3D=3D Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
> >  Marcelo> The intention of this email is to clarify my position on 2.4.=
x
> >  Marcelo> future.
> >=20
> >  Marcelo> 2.6 is becoming more stable each day, and we will hopefully
> >  Marcelo> see a 2.6.0 release during this month or January.
>=20
> I would argue that 2.2 wasn't really usable until somewhere around 2.2.12=
.
>=20
> I would also claim that 2.4 wasn't useful until 2.4.10.
>=20
> If we continue to improve along these lines, can I expect 2.6 to be=20
> generally usable somewhere around 2.6.8? :)
>=20
> > On my notebook, I have spent the last two years going through regular
> > painful kernel patching and upgrades.=20
>=20
> <snip>
>=20
> His experiences pretty much mirror my own -- ACPI has been an adventure,=20
> cpufreq occasionally didn't work, full USB doesn't work without ACPI, I=20
> need alsa drivers and ACPI in order to have acceptable sound, and I need=20
> to use GATOS drivers for my display, else 3d just blows chunks.
>=20
> For the longest time on this beast, kernel upgrades were a day long=20
> adventure.=20
>=20
> First, to push in acpi, cpufreq, and freeswan. (Oh, look, 2.4.foo is=20
> out ... but the latest ACPI patch was 2.4.foo-prebar and CPUfreq is=20
> 2.4.foo-pre(bar-2)-3weeks-earlier ... time to patch and resolve=20
> rejections!)
>=20
> Then it was off to put in alsa, radoen, freeswan, linux-wlan-ng and so=20
> forth ...
>=20
> Some things should be migrated in and updated. drm modules, for example. =
I=20
> would also vote for alsa being merged. ACPI was brought up to date in=20
> 2.4.22, I believe, but I haven't checked since then. It should also be=20
> relativelt current, IMHO.
>=20
> >   1) Please don't stop working (and that does include pulling in new
> >      stuff) on 2.4, as many people still have to use it.
> >=20
> >   2) Please don't start developing 2.7 too soon. Go for at least 6
> >      months of bug-fixing. During that time, patches with new features
> >      will accumulate anyway, so it isn't lost time. But it will at leas=
t
> >      prevent people from saying "well, I use 2.7.45 and it works for
> >      me".
>=20
> I have to agree with both of these points. 2.6.0 will probably have=20
> problems that will take a while to sort out. Putting it on systems to tes=
t=20
> is one thing, putting it into production as its the only blessed solution=
=20
> is another ...
--=20
Linux garaged 2.4.22-ac4 #2 SMP Mon Oct 6 14:33:25 UTC 2003 i686 Pentium II=
I (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-NUrL/aw839rL5hNVsGc2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/0fqNNNkpVEFxW78RAjjuAKCfQpWI9FXcudp8AYmHUYUk+0CD+wCaAyGX
tMq26xG+Z5Q2ZIawtYI5fOE=
=kuUP
-----END PGP SIGNATURE-----

--=-NUrL/aw839rL5hNVsGc2--

