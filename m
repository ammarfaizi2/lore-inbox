Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTA0KOW>; Mon, 27 Jan 2003 05:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTA0KOW>; Mon, 27 Jan 2003 05:14:22 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:52173
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S266718AbTA0KOV>; Mon, 27 Jan 2003 05:14:21 -0500
Subject: Re: any brand recomendation for a linux laptop ?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1043623577.22621.14.camel@sonja>
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
	<20030116104154.GL25246@pegasys.ws> <3E26BE43.6000406@walrond.org>
	<20030116144045.GC30736@work.bitmover.com>
	<20030116153727.GA27441@lug-owl.de>  <1042733652.18213.35.camel@sonja>
	<1042820273.8935.2.camel@lemsip>  <1042886952.24291.15.camel@sonja>
	<1043427661.28761.16.camel@lemsip>  <1043623577.22621.14.camel@sonja>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-nFl9KAUgogt5vskBgJHA"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Jan 2003 10:23:46 +0000
Message-Id: <1043663027.6975.18.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nFl9KAUgogt5vskBgJHA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-01-26 at 23:26, Daniel Egger wrote:
> Get a decent distribution. :)

debian i suppose? ;)

> 152 is nothing....

I was hoping so ;)

> This is not normal. Since the kernel doesn't know either the usable
> frequencies, your version of the cpu and no doze mode is available
> for this type, your energy savings are almost nil at the moment and this
> should definitely be rectified. I cannot imagine Apple built a CPU into
> a PowerBook which doesn't support some kind of throttling, because it
> would kill their statement under their OS, too.

OK, well just for your info, I added an entry in the cputable for
rev2.1, identical flags to the 2.0 entry and nothing has changed. Still
no cpufreq data, case is still warm all over. I put debug messages in to
my pmac_cpufreq.c and I get the following:

HID1, before: 80016c0
HID1, after: 16080

> Unfortunately I'll have a whole bunch of nasty tests the following week
> and thus cannot check back with the manuals at the moment; feel free to
> send me a reminder in a week or so.

Cool will do! I'd be very interested to see any ppc/powermac manuals you
may have. I've not been able to find much myself (just instruction
reference and stuff from motorola). If you could send me URLs that would
great.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-nFl9KAUgogt5vskBgJHA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+NQiykbV2aYZGvn0RAtMJAJ44A10uB7QnzL23DwD+Exmc3YoH8ACfYNmb
2ewGVtTFr2V2OxrqjrGCycE=
=L3Kp
-----END PGP SIGNATURE-----

--=-nFl9KAUgogt5vskBgJHA--

