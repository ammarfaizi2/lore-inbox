Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVEMSdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVEMSdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVEMSdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:33:32 -0400
Received: from thoth.sophic.org ([70.88.204.20]:64243 "EHLO thoth.sophic.org")
	by vger.kernel.org with ESMTP id S262470AbVEMSdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:33:23 -0400
Date: Fri, 13 May 2005 14:33:23 -0400
From: Derek Martin <code@pizzashack.org>
To: linux-kernel@vger.kernel.org
Subject: SCSI debug info
Message-ID: <20050513183323.GA14547@sophic.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm a system administrator at a company with a large number of
machines at remote locations.  Naturally, many of these machines
develop hardware problems, and some may be deployed with SCSI
connections that aren't so connected after all.

I'm wondering if there is any documentation which can explain how to
interpret the error messages which the kernel reports, for those of us
who are mere mortals (i.e. neither experienced Linux kernel developers
nor SCSI gods).  The messages reported are pretty much unintelligible
to those of us who didn't major in SCSI in college. :)  Actually I
pinged some people recently who have done kernel development
professionally, and the response was generally that even with the
source code in front of you, the messages still tend to be a bit
cryptic...

So any links to relevant info would be appreciated.  I'm specifically
interested in identifying messages which would help differentiate
the category of problems, e.g. disk failure from controller meltdown,
=66rom poor connectivity on the SCSI bus, etc. (though I can imagine
that perhaps it isn't always easy to differentiate each of those in
software).  Having a solid clue to the real problem would save lots of
time (and money) troubleshooting.

I'm sure someone will suggest installing diagnostic utilities, but for
various reasons that's not possible in the short term.  Besides which
I'd generally like to understand the kernel messages anyway, but
preferably without the hundreds of hours it would take me to pour
over, research, and understand the kernel code.  Much as I'd love to
have time to be a kernel hacker, I just don't.

I'm also wondering if there is any plan to make the kernel messages
more generally intelligible to us common folk.  If there isn't, I'd
like to suggest it as a future feature enhancement. :)

Thanks much!

--=20
Derek D. Martin
http://www.pizzashack.org/
GPG Key ID: 0x81CFE75D


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFChPLydjdlQoHP510RAryVAJ43hyKAhJm/lRPqiL3Uw7mNiV3ceQCeIpvc
EGGTJXY2WnO33+AFJ9+ao9U=
=nllj
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
