Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUIUMOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUIUMOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUIUMNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:13:19 -0400
Received: from dialin-212-144-167-176.arcor-ip.net ([212.144.167.176]:65414
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S267612AbUIUMLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:11:16 -0400
In-Reply-To: <1095686020.26647.10.camel@localhost.localdomain>
References: <20040919095857.GD17602@lain.chroot.de> <1095686020.26647.10.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-24--650186704"
Message-Id: <3153148F-0BC7-11D9-9709-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Aiko Barz <aiko@chroot.de>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: WRT54G
Date: Tue, 21 Sep 2004 14:10:13 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-24--650186704
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 20.09.2004, at 15:13, Alan Cox wrote:

>> This site http://www.linksys.com/support/gpl.asp also implies, that i
>> can redistribute those drivers and firmwares. But it is the same
>> problem with them. Those wrt54g-firmwares also contain non-GPL
>> sourcecodes and binaries.

> It's up to Linksys what license they grant you for their non-free 
> stuff.
> If its linked with GPL stuff then it might be GPL because its a
> derivative work. Sveasoft's only business is code they own the 
> copyright
> to themselves and didn't give other people rights to redistribute (or
> gave them specifically revokable rights to distribute)

IANAL but I'd very calm about this specific threat. Linksys published
the complete source code to this router product including Makefiles
to build your own firmware. The only parts which were only delivered
as binaries are the tools to assemble a firmware, the bootloader and
the helper code for the OpenSource module controlling the WLAN chipset.

Most of the software they bundle is GPL (including the kernel, uclibc
(LGPL), busybox, iptables, dnsmasq...) so Linksys is doing pretty well
in releasing the source. The also include applications which are
marked "propietary" but AFAIS they're not linked against any GPLed
source so I'd consider them still as belonging to Linksys.

IOW if Sveasoft is distributing any *part* of the original firmware
(and they have to at least for the WLAN interface) they're in
violation of the GPL *and* (probably illegally) distributing
propietary applications written or licensed by Linksys. And I really
doubt they changed the OS to something non-GPLed and use a
completely different environment.

If I were them I'd rather hide behind rock and hope that noone
notices that they're violating licenses instead of threatening people.

Servus,
       Daniel

--Apple-Mail-24--650186704
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQVAaJjBkNMiD99JrAQKxXwf+JWD1SLL7CziGy5qZaBlarnuVHAQxKe1C
rKzE3ACaY1BBmrTfjiy6OAGIpmtgYzkb65VavN5FzAeML9TWSP4idsBnA2cc1cfA
RTznGYfpadvnIVuWfAMb3LjJUyMynX4AIbLqt30UR25ORuQi86sYE4MYOTPxHqZ5
+nkpRDLAwjn6nUF8FvzHPghP6SISRUkCIH9Hpvgj9FZKLa1hF+DGwVPRvg+AdwFS
TOOoocNdGFqro3gwTRQfZevw2acNDgdrUopMBQHfiDv9ISzoNGsOgNKw3p+29J+p
95JZMXzn7OlpabOHb0zVrTV3OeH8HQW4wBDsRgtJxNNptQ0jbs7+5w==
=gVEB
-----END PGP SIGNATURE-----

--Apple-Mail-24--650186704--

