Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264694AbUD1ImU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbUD1ImU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUD1ImU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:42:20 -0400
Received: from mx2.redhat.com ([66.187.237.31]:982 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264694AbUD1ImN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:42:13 -0400
Subject: Re: [ACPI x86_64] 2.6.1-rc{1,2} hang while booting on Sun v20z aka
	Newisys 2100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Len Brown <len.brown@intel.com>
Cc: Shantanu Goel <Shantanu.Goel@lehman.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1082667692.16337.400.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
	 <1082653547.16336.335.camel@dhcppc4> <408820D7.10400@lehman.com>
	 <1082666116.16336.391.camel@dhcppc4>  <40882E49.2040705@lehman.com>
	 <1082667692.16337.400.camel@dhcppc4>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Nov/GbpO+M0KgeQO4Hhc"
Organization: Red Hat UK
Message-Id: <1082811291.3918.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Apr 2004 04:42:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Nov/GbpO+M0KgeQO4Hhc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

\
> Perhaps you can enumerate what kernels do boot on this box.
> If there is RH special sauce at work, then I'd expect that
> none of the kernel.org 2.4 kernels boot either.

we have nothing magic in the acpi code in RHEL3 really; just a patch to
take it to a slightly newer version from you guys... (one that works on
both x86_64 and ia64)

--=-Nov/GbpO+M0KgeQO4Hhc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAimOaxULwo51rQBIRAu43AJ4nboS8DjC/91qGzHBTH6t0bxwU3QCaAt7s
nnqUSiQEwLIqiGcXikBoFC8=
=lKEg
-----END PGP SIGNATURE-----

--=-Nov/GbpO+M0KgeQO4Hhc--

