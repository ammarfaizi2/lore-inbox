Return-Path: <linux-kernel-owner+w=401wt.eu-S1161106AbWLVJxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWLVJxm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 04:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWLVJxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 04:53:41 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:16140 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161106AbWLVJxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 04:53:40 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 04:53:40 EST
Date: Fri, 22 Dec 2006 10:47:04 +0100 (MET)
From: Wolfgang Draxinger <wdraxinger@darkstargames.de>
Organization: DARKSTARgames
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Binary Drivers
User-Agent: KMail/1.9.5
References: <MDEHLPKNGKAHNMBLJOLKGEGDAIAC.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEGDAIAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: multipart/signed;  boundary="nextPart12556087.UcXaZUhroC";
  protocol="application/pgp-signature";  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612221046.43305.wdraxinger@darkstargames.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12556087.UcXaZUhroC
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 21. Dezember 2006 21:50 schrieb David Schwartz:

> Honestly, I think it *is* wrong to sell someone a physical product
> and then not tell them how to make it work. If you're not actually
> selling them the physical product but selling them a way to get a
> particular thing done, then don't represent that you're selling
> them physical product because that would presumably include the
> right to use it any way they wanted provided it was lawful.

My opinion, too. I wasted months to get specifications for a=20
particular HW once and I've heared them all:

* "We can't publish documentation due to 3rd party patents" (Unh, I=20
thought, that patents are there, _that_ you can safely publish).

* "It would be expensive for us to publish documentation" (Wouldn't=20
that save the in house development of drivers, the kernel developers=20
would that for you _and_ maintain it).

* "We've lost the documentation" (Aaahaaa, lame excuse)

And sometimes they are honest: "We don't want to publish". If it is=20
rare, special hardware, like measurement interfaces I found out, that=20
you can put a lot of pressure on them, if you return them their=20
hardware, and claim your money back telling them the reason, why=20
their product is inapropriate. If they don't accept that, sue them=20
for fraud (you expected a working product, but it doesn't work with=20
your system). But most of the time they fear to loose one of their=20
precious customers and get quite talkative. But in the consumer=20
market a margin of +/-0.5M users doesn't put force on vendors selling=20
~10M units, so not buying is not an option.

Personally I've given up to tell HW manufators directly. Instead I=20
tell people what to buy and what not and to send protest letters the=20
hardware vendors - hey for something that registration cards coming=20
with the product must be good for.

On the long term I think, that the only way to force hardware vendors=20
to publish all documentation is by going the legislative way, i.e.=20
getting politically active, with the goal being a law, that anyone,=20
selling a product _must_ provide detailed documentation for free,=20
that enable one to understand use and maintain the product and it's=20
individual components without requiring additional restricted=20
information from the manufactor.
Anything else creates a maintenance and support monopoly for the=20
manufactor, which distorts the free market.

IMHO hardware documentation disclosure is of uttermost importance,=20
since if the manufactor goes out of buisnes you mostly have some bad=20
luck.

2 years ago I bought on eBay a small DECT PCI adapter with the=20
intention to connect it with Asterisk someday - knowing that there=20
are no Linux drivers and that the manufactor got bankrupt and was=20
bought by a competitor. I didn't even got replies to my documentation=20
requests addressed at the new owner of the IP. Quite disappointing.=20
At least the driver CD contains also VxD drivers, which are quite=20
easy to reverse engineer, but I haven't yet found the time to do so.

BTW: Does anybody know a not too expensive way to have some silicon=20
created from a VHDL? Eventually it would be easier to design our own=20
hardware, than being dependent on some manufactor. But there are=20
plenty of quite trivial patents, like this one, making you "aaarghh":
<http://tinyurl.com/yl4d2n>

But I think, that Linux can also add some force on the manufactors if=20
we want a little bit: Already Linux is a vital component in many=20
operations. For example Hollywood: There are virtually none rendering=20
farms running not under Linux, there, a few MacOS X, a few Solaris=20
and a few Irix. The same goes for the workstations. Now give Linux=20
another 2 years to diffuse into widespread market. I'm quite sure,=20
that within the next year a lot of users will look for alternative=20
OS, when their Windows Vista refuses to reactivate, once they changed=20
their hardware for the 2nd time. WinXP support is said to be=20
cancelled a lot earlier. People still have their hardware then, not=20
wanting to invest into a Mac, just to get a good OS. Instead they=20
will remeber that free Knoppix/Kanotix/Ubuntu LiveCD, wich came with=20
their computing magazine and that they tried out, found it nice but=20
didn't migrate fearing the effort. But the isntalled OS refuses to=20
work, demanding reactivation and that LiveCD is a comfortable way to=20
continue work. Then they install it, and at some point HW manufactors=20
_must_ provide Linux drivers. It doesn't matter if they are OSS yet.=20
Just let them deliver and gain Linux a not neglectible consumer=20
market share. Then forbid CSS drivers in the kernel, not aprupt, but=20
with enough migration time. Hardware manufactors will have to=20
disclose information, if they don't want to loose customers. But=20
since the migration is done smoothly customers will experience their=20
systems failing - due to the older CSS only drivers. But HW vendors=20
are forced to open the spec for new products, to that the drivers are=20
not illegal and may be delivered with the product/integrated into the=20
kernel. Without working drivers the product is worthless and people=20
using Linux won't buy a product not supported. It's a pervasive long=20
time plan, but it might work - if Microsoft plays along and keeps=20
it's user gaging restrictions.

This is purely politics, I know, but unfortunately this is probably=20
the only way to get it done. Marketeers and attornerys are technical=20
illiterates numb to technical argumentation. I don't like it, but it=20
seems, that we've to adopt some of their methods...

Wolfgang Draxinger

--nextPart12556087.UcXaZUhroC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFi6mDBfWmRR/TvT4RAjFNAKDR0fuDeZhRipuxvs0QLEzo7dYEuwCfdaV7
0RQ3vLA/h9b7vDQ38AKrV8Y=
=7kRb
-----END PGP SIGNATURE-----

--nextPart12556087.UcXaZUhroC--
