Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUIUTWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUIUTWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUIUTWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:22:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58605 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267993AbUIUTVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:21:50 -0400
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alex Williamson <alex.williamson@hp.com>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1095794035.24751.54.camel@tdi>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz>  <20040921190606.GE18938@wotan.suse.de>
	 <1095794035.24751.54.camel@tdi>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2Uc9tMqMO7Ykamqqpj04"
Organization: Red Hat UK
Message-Id: <1095794482.21532.17.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 21:21:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Uc9tMqMO7Ykamqqpj04
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-21 at 21:13, Alex Williamson wrote:
> this interface.  They are not actually pointers.  I believe the 32bit
> emulation problem is limited to an ILP32 application generating data
> structures appropriate for an LP64 kernel.  While difficult, it can be
> done.

more like a LP64 kernel getting data structures a ILP32 application
generated and needing to make sense of it.


--=-2Uc9tMqMO7Ykamqqpj04
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBUH8xxULwo51rQBIRAqrpAKCeJmEwOddXdiEtgTBEDTbTzWbP9gCfXWqf
9mVJFTj2nLLH3lcEHoJU9n0=
=yhfj
-----END PGP SIGNATURE-----

--=-2Uc9tMqMO7Ykamqqpj04--

