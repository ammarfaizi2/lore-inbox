Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTE0OXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTE0OXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:23:08 -0400
Received: from adsl-66-137-214-207.dsl.stlsmo.swbell.net ([66.137.214.207]:38794
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id S263631AbTE0OXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:23:07 -0400
Subject: Re: Finding reason for "Attempted to kill init"
From: Stephen Torri <storri@sbcglobal.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200305271219.h4RCJSu10402@Port.imtp.ilyichevsk.odessa.ua>
References: <1053993371.17560.16.camel@base>
	 <200305271219.h4RCJSu10402@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ar5iGH/J27wu/QKtruYU"
Organization: 
Message-Id: <1054046931.26795.9.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 27 May 2003 09:48:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ar5iGH/J27wu/QKtruYU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-27 at 07:25, Denis Vlasenko wrote:
> On 27 May 2003 02:56, Stephen Torri wrote:
> > I can see from kernel/exit.c where the message "Attempted to kill
> > init" comes from in the kernel. That is good. What would be helpful
> > is to deteremine where in the code the function do_exit() is called.
> > Is there a way to do that? I am trying to hunt down a boot failure
> > for a kernel on a Gentoo LiveCD. I am in communication with the
> > developers of the Gentoo Alpha list about this problem?
>=20
> Your /sbin/init exits
> --
> vda

So because this binary file exists the kernel will not boot?

Stephen
--=20
Stephen Torri <storri@sbcglobal.net>

--=-Ar5iGH/J27wu/QKtruYU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+03rTmXRzpT81NcgRAiGiAJ9fk/RWZWAlrLC92LTHXDaR4ftZYwCeIB8L
DWXTFP1K39FyMf5MABiGBYE=
=BPuk
-----END PGP SIGNATURE-----

--=-Ar5iGH/J27wu/QKtruYU--

