Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVDFTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVDFTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVDFTdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:33:16 -0400
Received: from admingilde.org ([213.95.21.5]:62104 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S262302AbVDFTdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:33:07 -0400
Date: Wed, 6 Apr 2005 21:31:26 +0200
From: Martin Waitz <tali@admingilde.org>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC 1/6]SEP initialization rework
Message-ID: <20050406193126.GA4458@admingilde.org>
Mail-Followup-To: Li Shaohua <shaohua.li@intel.com>,
	lkml <linux-kernel@vger.kernel.org>,
	ACPI-DEV <acpi-devel@lists.sourceforge.net>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
References: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1112580349.4194.331.camel@sli10-desk.sh.intel.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.8i
X-Hashcash: 0:050406:len.brown@intel.com:96dc3b7856fbab2b
X-Hashcash: 0:050406:shaohua.li@intel.com:1202e3de3f23a7ae
X-Hashcash: 0:050406:zwane@linuxpower.ca:d609ca48b37a63b7
X-Hashcash: 0:050406:acpi-devel@lists.sourceforge.net:fa1784ba8d64dbb5
X-Hashcash: 0:050406:pavel@suse.cz:66b7e2acd0740046
X-Hashcash: 0:050406:linux-kernel@vger.kernel.org:07143a7ff19ac41c
X-Spam-Score: -12.9 (------------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Apr 04, 2005 at 10:05:56AM +0800, Li Shaohua wrote:
> -	on_each_cpu(enable_sep_cpu, NULL, 1, 1);

with this on_each_cpu call gone, you should also be able to remove the
useless info pointer in enable_sep_cpu.

--=20
Martin Waitz

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCVDkNj/Eaxd/oD7IRAsm6AJ0Yp8v8DgJoRk4Jyef2YfDTYIPn0gCbBaoU
PpP73OaO2mgaJ815ZACXC2s=
=XlG5
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

