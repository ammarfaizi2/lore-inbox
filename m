Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTIOKXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTIOKXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:23:11 -0400
Received: from coruscant.franken.de ([193.174.159.226]:45707 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S262461AbTIOKXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:23:07 -0400
Date: Mon, 15 Sep 2003 12:18:26 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: firewalling PPPOE stream without terminating it
Message-ID: <20030915101826.GH777@obroa-skai.de.gnumonks.org>
References: <3F61D8E4.6020309@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
In-Reply-To: <3F61D8E4.6020309@nortelnetworks.com>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.0-test4
X-Date: Today is Pungenday, the 39th day of Bureaucracy in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris!

On Fri, Sep 12, 2003 at 10:32:04AM -0400, Chris Friesen wrote:

> I've got a PPPOE DSL line coming into my house, and I and my roommates=20
> each terminate our own connection and get our own dynamic IP address.

So how is this question related to either=20
1) network development (netdev@oss.sgi.com)
2) linux-kernel development (linux-kernel@vger.kernel.org)

I would like to ask you this question at an apropriate mailinglist
(netfilter@lists.netfilter.org, or the lartc mailinglist [since the
assumption that you would need to do NAT in case you terminate the two
dsl lines is invalid an can be solved using policy routing + connmark]).

> Chris Friesen                    | MailStop: 043/33/F10

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ZZHxXaXGVTD0i/8RAtypAJ90Bhd5kA4bxDUHle4YxlJzkwORvwCfbboN
7oYLitTanO8CoR0tKPUjiDM=
=/4fn
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--
