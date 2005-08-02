Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVHBRBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVHBRBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVHBRBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:01:00 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:11000 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261659AbVHBRA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:00:58 -0400
Message-ID: <42EFA70A.2090702@punnoor.de>
Date: Tue, 02 Aug 2005 19:02:02 +0200
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: James Bruce <bruce@andrew.cmu.edu>, sclark46@earthlink.net,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730195116.GB9188@elf.ucw.cz>	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>	 <1122852234.13000.27.camel@mindpipe>	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>	 <20050801204245.GC17258@thunk.org> <42EEFB9B.10508@andrew.cmu.edu>	 <42EF70BD.7070804@earthlink.net>  <42EF947E.1070600@andrew.cmu.edu> <1122998296.11253.25.camel@mindpipe>
In-Reply-To: <1122998296.11253.25.camel@mindpipe>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig969F8DCEF85DDFFB4EEA9A18"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig969F8DCEF85DDFFB4EEA9A18
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Lee Revell schrieb:
> On Tue, 2005-08-02 at 11:42 -0400, James Bruce wrote:
> 
>>I do like saving power, which is why I run cpu frequency scaling on 
>>every machine I have that supports it.
> 
> 
> My Athlon XP desktop doesn't support frequency scaling but has working
> ACPI C-states (at least under Windows) so will run as cool as 31C when
> idle (with the CPUIdle utility).  Most of the heat comes from the hard
> drives anyway, but that's a different story.
> 
> This seems pretty cool to me, how much more power does frequency scaling
> save over that, assuming you suspend after 5-10 minutes of inactivity
> anyway?

I am a gentoo user an compile a lot of things. I also use freq scaling with my
Athlon XP on nforce2 with cpu disconnect enabled.

idle at ~1400MHz:      ~135 WATT used by system
full load at ~1400MHz: ~150 WATT
full load at ~2200MHz: ~230 WATT

So, if I don't need something very quickly, so can guess that I prefer to do
compiling at low clock speeds... (Suspend won't work for me.)

Cheers,

Prakash

--------------enig969F8DCEF85DDFFB4EEA9A18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC76cKxU2n/+9+t5gRAgCwAKDV8RQeUkDFc6PgpIf5hkgZSgCslwCfS3ay
GgRQdAuh0TZMUWPMq6SMS4g=
=w6tf
-----END PGP SIGNATURE-----

--------------enig969F8DCEF85DDFFB4EEA9A18--
