Return-Path: <linux-kernel-owner+w=401wt.eu-S1753233AbWLYAar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbWLYAar (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 19:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbWLYAar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 19:30:47 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:57043 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbWLYAaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 19:30:46 -0500
Date: Mon, 25 Dec 2006 01:30:41 +0100 (MET)
From: Wolfgang Draxinger <wdraxinger@darkstargames.de>
Organization: DARKSTARgames
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Binary Drivers
User-Agent: KMail/1.9.5
References: <200612242020.kBOKKtS9009605@laptop13.inf.utfsm.cl>
In-Reply-To: <200612242020.kBOKKtS9009605@laptop13.inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: multipart/signed;  boundary="nextPart1430551.JLlZ0uriNR";
  protocol="application/pgp-signature";  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612250133.27413.wdraxinger@darkstargames.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1430551.JLlZ0uriNR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag, 24. Dezember 2006 21:20 schrieb Horst H. von Brand:

> It is done regularly. Current cars control the fuel injection etc
> via an onboard computer, without this control the engine just won't
> start. Did you get the specs for the exact fuel control algorithm
> with your car? Should you be able to fool around with that, thus
> violating emission control measures (this would damage not only
> you, but everybody)?

You won't get access to the software source code, but the car=20
manufactors are required to document and publish the interfaces to=20
their hardware, so that also independent car workshops are able to do=20
maintenance and repair on it.

You have ever heared of chip tuning? Chip tuning is a replacement of=20
the original firmware with a 3rd party one, that will give higher=20
power and torque.

So your gave a perfect example from another industry, where the specs=20
are actually published.

Again: We don't want the original drivers being open sourced. All we=20
want is access to the hardware interface documentation, so that we=20
can develop our very own drivers. And heck: With a custom driver for=20
some RAID controller or a graphics card you will hardly violate any=20
regulations.

There might be issues with radio hardware, but surprisingly the=20
drivers for the good stuff (i.e. not those cheapo cards with lousy=20
range and throughput) are open source (Prism/HostAP).

I'd even say, that selling hardware without giving documentation is=20
illegal also from a competitions law point of view. By supplying a=20
driver only for a small range of operating systems you, as the=20
factual owner of a piece of hardware are hindered to use it in the=20
way you like, e.g. use it with the homebrew operating system you=20
wrote (or a finnish student wrote in 1991 ;-)). Thus the HW=20
manufactor delivering drivers only for a small range of operating=20
systems can be assumed to distort the market by biasing one specific=20
operting system manufactor _and_ hardware manufactors. Remember, that=20
many binary only drivers for Linux are only avaliable for the x86=20
variant. Only few are also avaliable for x86_64 (AMD64), even fewer=20
for IA64 and for other architectures it's getting homeopathic. This=20
is IMHO a extreme distortion of the free market.

Happy holydays

Wolfgang Draxinger

--nextPart1430551.JLlZ0uriNR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFjxxXBfWmRR/TvT4RAnyQAJwJgVI67g0uLlQdsCvLXK7pP9ZvCwCg7w5w
UOTTUN67MVfjF0RNMys790Y=
=AlWl
-----END PGP SIGNATURE-----

--nextPart1430551.JLlZ0uriNR--
