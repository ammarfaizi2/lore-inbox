Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132978AbRDRCBt>; Tue, 17 Apr 2001 22:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132979AbRDRCBj>; Tue, 17 Apr 2001 22:01:39 -0400
Received: from topic-gw2.topic.com.au ([203.37.31.2]:23799 "HELO
	mailhost.topic.com.au") by vger.kernel.org with SMTP
	id <S132978AbRDRCBY>; Tue, 17 Apr 2001 22:01:24 -0400
Date: Wed, 18 Apr 2001 12:01:02 +1000
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac9
Message-ID: <20010418120102.B29749@topic.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alan,

This does not seem to fix the problem with "clock timer", which
repeatedly prints the following message:

probable hardware bug: clock timer configuration lost - probably a VIA686a =
motherboard.
probable hardware bug: restoring chip configuration.

The machine does not get any further than printing the above message.
This message only appears with an SMP kernel, there are no ide devices
in the machine.

a generic 2.4.3 kernel works on the machine.

Thanks.


On Mon, 16 Apr 2001, Alan Cox wrote:

> VIA users should test this kernel carefully. It has what are supposed
> to be
> the right fixes for the VIA hardware bugs. Obviously the right fixes
> are not
> as tested as the deduced ones.

--=20
Jason Thomas                           Phone:  +61 2 6257 7111
System Administrator  -  UID 0         Fax:    +61 2 6257 7311
tSA Consulting Group Pty. Ltd.         Mobile: 0418 29 66 81
1 Hall Street Lyneham ACT 2602         http://www.topic.com.au/

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63PVe7cYwRJJSiL4RAv29AKDWWE7+gVdJ9/Cyx1h3CS3mb9QTswCg6zpi
XtkTuuwnX4ZqznwooMz2Ru8=
=7G3+
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
