Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTJXRFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTJXRFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:05:23 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:31732 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262418AbTJXRFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:05:18 -0400
Subject: Re: Copying .config to /lib/modules/`uname -r`/kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Pavel Roskin <proski@gnu.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0310241234010.1701@marabou.research.att.com>
References: <Pine.LNX.4.58.0310240406230.17536@portland.hansa.lan>
	 <20031024155343.GP5017@actcom.co.il>
	 <Pine.LNX.4.56.0310241234010.1701@marabou.research.att.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ihV9LmxhV0LT5YAyeTk8"
Organization: Red Hat, Inc.
Message-Id: <1067015103.5255.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Fri, 24 Oct 2003 19:05:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ihV9LmxhV0LT5YAyeTk8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-10-24 at 18:50, Pavel Roskin wrote:
\
> It's missing on Red Hat Linux.

It's not missing. For 2.4 kernels you don't need it to build external
modules against. For the 2.6 kernel rpms
(http://people.redhat.com/arjanv/2.5/ </shamelessplug>) the config is
there as required



--=-ihV9LmxhV0LT5YAyeTk8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/mVu/xULwo51rQBIRAkaQAJ9TSH56JHT81g5nS/H3w/3IGtdzpQCggJlv
eYvosQ2Rp2tGCPvzbJo5TlY=
=orSu
-----END PGP SIGNATURE-----

--=-ihV9LmxhV0LT5YAyeTk8--
