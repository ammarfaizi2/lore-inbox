Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264038AbUD2KMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbUD2KMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 06:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUD2KMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 06:12:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264038AbUD2KMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 06:12:17 -0400
Subject: Re: userspace pci config space accesses
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Brian King <brking@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <40904E72.7020308@us.ibm.com>
References: <409026CE.8050905@us.ibm.com> <20040428225236.GA27250@kroah.com>
	 <40903DBD.1000704@us.ibm.com> <20040428233812.GA365@kroah.com>
	 <40904E72.7020308@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0zYYTXCoFLUH84pbtiXC"
Organization: Red Hat UK
Message-Id: <1083233495.4634.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Apr 2004 12:11:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0zYYTXCoFLUH84pbtiXC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Yeah, mdelay(2000) kind of sticks out in a code review;)

mdelay() isn't enough; think SMP.


--=-0zYYTXCoFLUH84pbtiXC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAkNTWxULwo51rQBIRAusRAJ4hWCIZNpd+uXtjrPzbBaERAQW1TQCfYzde
gFNKW7U3ptS20p6uMz/tOIA=
=4fkF
-----END PGP SIGNATURE-----

--=-0zYYTXCoFLUH84pbtiXC--

