Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUAVI7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUAVI7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:59:45 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:34694 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266016AbUAVI7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:59:42 -0500
Date: Thu, 22 Jan 2004 22:02:30 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Export console functions for use by Software Suspend	nice
 display
In-reply-to: <20040122082809.A7699@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074762149.12773.24.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-9Sw4wz4WJBTLWlgyScZB";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074757083.1943.37.camel@laptop-linux>
 <20040122082809.A7699@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9Sw4wz4WJBTLWlgyScZB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

'Nice display' means that it gives a simple, clean display with progress
bar etc. Al(?) Viro has informed me of the write call. I'll look it up
and see how I can improve things. As I said to Mr Viro, I'm just a user
who wanted Suspend to work better and ended up just about rewriting the
thing. Please forgive my ignorance!

Regards,

Nigel

On Thu, 2004-01-22 at 21:28, Christoph Hellwig wrote:
> On Thu, Jan 22, 2004 at 09:12:00PM +1300, Nigel Cunningham wrote:
> > Hi.
> >=20
> > Here's a second patch; this exports gotoxy, reset_terminal, hide_cursor=
,
> > getconsxy and putconsxy for use in Software Suspend's nice display.
>=20
> Really, swsusp shouldn't mess with console internals.  And you don't even
> explain what "nice display" is supposed to mean.
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-9Sw4wz4WJBTLWlgyScZB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAD5GlVfpQGcyBBWkRAtu5AJ9183NYfBGzHjdqOxbI+G++jbE5pwCdEkIB
a0IxsYNKLG9haeNxBTCn/G4=
=T7P7
-----END PGP SIGNATURE-----

--=-9Sw4wz4WJBTLWlgyScZB--

