Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTJSQ13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTJSQ13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:27:29 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:21231 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261732AbTJSQ12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:27:28 -0400
Subject: Re: [2.6 patch] add a config option for -Os compilation
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <668910000.1066578207@[10.10.2.4]>
References: <20031015225055.GS17986@fs.tum.de>
	 <20031015161251.7de440ab.akpm@osdl.org><20031015232440.GU17986@fs.tum.de>
	 <20031015165205.0cc40606.akpm@osdl.org><20031018102127.GE12423@fs.tum.de>
	 <649730000.1066491920@[10.10.2.4]><20031018102402.3576af6c.akpm@osdl.org>
	 <20031018174434.GJ12423@fs.tum.de> <20031018105733.380ea8d2.akpm@osdl.org>
	 <668910000.1066578207@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GTGe9eYsBVklmzRXVj9I"
Organization: Red Hat, Inc.
Message-Id: <1066580758.5243.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Sun, 19 Oct 2003 18:25:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GTGe9eYsBVklmzRXVj9I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-10-19 at 17:43, Martin J. Bligh wrote:

> So why are we changing it then? ;-) We don't seem to have much evidence
> either way. What are the distros doing?

in the context of boot/rescuefloppies (yes those pesky black things
still exist) I would seriously consider -Os, esp if there's no big
peformance disadvantage....

--=-GTGe9eYsBVklmzRXVj9I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/krsVxULwo51rQBIRAn4uAKCdyXOv1SHvHMDOTA2CgeqhxGOwJgCeLmjr
e9Ra+gAZAZdD44rKu2bLXBs=
=34R5
-----END PGP SIGNATURE-----

--=-GTGe9eYsBVklmzRXVj9I--
