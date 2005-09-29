Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVI2JrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVI2JrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVI2JrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:47:04 -0400
Received: from mail.parbin.co.uk ([213.162.111.43]:63624 "EHLO
	mail.parbin.co.uk") by vger.kernel.org with ESMTP id S1751309AbVI2JrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:47:02 -0400
Date: Thu, 29 Sep 2005 10:45:00 +0100
From: Alexander Clouter <alex@digriz.org.uk>
To: Stefan Seyfried <seife@suse.de>
Cc: Blaisorblade <blaisorblade@yahoo.it>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.14] Cpufreq_ondemand sysfs names change
Message-ID: <20050929094500.GF3169@inskipp.digriz.org.uk>
References: <200508232108.26248.blaisorblade@yahoo.it> <200509101536.10307.blaisorblade@yahoo.it> <20050910140148.GC7072@inskipp.digriz.org.uk> <200509271851.36706.blaisorblade@yahoo.it> <433BABA9.8070908@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Content-Disposition: inline
In-Reply-To: <433BABA9.8070908@suse.de>
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stefan Seyfried <seife@suse.de> [20050929 10:54:01 +0200]:
>
> >> My thinking too, its a relatively new feature and when I have looked a=
round
> >> very few userland tools even tinker with ondemand so either we do it n=
ow or
> >> not at all...or rather we do it later and listen to everyone complain =
:)
>=20
> so the early birds are doomed? ;-)
>
they don't call it *bleeding* edge for no reason ;)  I'll promise not to fl=
ip=20
it back again, deal?

> I'll bite the bullet if this "flip the meaning" gets in, but i don't
> like it. I'll have to check for the kernel version in my userspace code,
> then which is generally a bad idea IMO.
>
I agree, its messy that this was not dealt with on day one before the code=
=20
was even merged but the meaning is logically the other way round to what yo=
u=20
would expect it to mean from reading the sysfs name.  Joe Public is going t=
o=20
get confused on this one, rightly so too.

Cheers

Alex

> --=20
> Stefan Seyfried                  \ "I didn't want to write for pay. I
> QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
> SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen

--=20
 ______________________________________=20
/ A day without sunshine is like a day \
\ without Anita Bryant.                /
 --------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDO7ecNv5Ugh/sRBYRAkyvAJ9AbjQ7UugjHBnA7fFP6H/d2RsOCQCfaoCA
DhZ850mmJX+xYouDkdVLNTw=
=PdWw
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--
