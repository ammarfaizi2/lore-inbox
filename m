Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTKMTaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTKMTav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:30:51 -0500
Received: from dd1234.kasserver.com ([81.209.148.157]:52183 "EHLO
	dd1234.kasserver.com") by vger.kernel.org with ESMTP
	id S264401AbTKMTat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:30:49 -0500
Date: Thu, 13 Nov 2003 19:30:43 +0000
From: Jochen Voss <voss@seehuhn.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
Message-ID: <20031113193043.GA1366@seehuhn.de>
References: <7F740D512C7C1046AB53446D37200173618736@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D37200173618736@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 13, 2003 at 10:56:34AM -0800, Nakajima, Jun wrote:
> Which kernel is this?
It is 2.6.0-test9 source from Debian, which Herbert Xu's patch
to make it boot.

> In 2.6 we don't look at the MPS table if ACPI is
> available. Or ACPI detection is failing?
How do I check this?  The calling chain which leads to the "BIOS bug,
MP table errors detected!" message is described in my original report

    http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0894.html

Other relevant information:

the full dmesg output: http://seehuhn.de/comp/dmesg-2.6.0-test9
my kernel config file: http://seehuhn.de/comp/config-2.6.0-test9
Herbert's patch: http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0879.=
html

I hope this helps,
Jochen
--=20
http://seehuhn.de/

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/s9vif+iD8yEbECURApj2AKC2BNF1E7hyO2wg/5+HDgvMGxxvtwCfSoQ+
yS1+TMQmRLJ+KvkXyXxqrgg=
=SFwS
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
