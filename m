Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272049AbRHVRdz>; Wed, 22 Aug 2001 13:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272065AbRHVRdo>; Wed, 22 Aug 2001 13:33:44 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:42813 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272060AbRHVRdg>; Wed, 22 Aug 2001 13:33:36 -0400
Date: Wed, 22 Aug 2001 12:33:50 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Travis Shirk <travis@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Locking Up
Message-ID: <20010822123350.D20693@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Travis Shirk <travis@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net> <E15ZbjI-0001s2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15ZbjI-0001s2-00@the-village.bc.nu> from Alan Cox on 08/22/2001 12:23
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yes, I have seen it happen a couple times before
I started X, within a couple minutes of boot completing.

		tw

On 08/22/2001 18:23 +0100, Alan Cox wrote:
>>	> The symptons are total lock-up of the machine.  No mouse
>>	> movement, all GUI monoitors freeze, and I cannot switch to a
>>	> virtual console.  I'm not able to ping the locked machine or
>>	> ssh/telnet into it either.  So I'm left wondering....how and
>>	> the hell to I debug this problem.  It'd be nice to have some
>>	> more information to go on or post to the list.
>>=09
>>	Can you get it to crash when you are not in X11 at all ?
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
twalberg@mindspring.com

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO4Ps8sPlnI9tqyVmEQJl7ACgzNXoqSv39I3aVCqSTq3VHbhVrjMAnAgs
JPNdawt6ZOVnI33h5sPkGOhM
=3lT8
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
