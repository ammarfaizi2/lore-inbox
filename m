Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263876AbUD0HJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUD0HJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 03:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUD0HJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 03:09:17 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:49158 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S263888AbUD0HJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 03:09:11 -0400
Subject: Re: User space programs on swsusp
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: rajsekar@peacock.iitm.ernet.in
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <y49ad0yng3b.fsf@sahana.cs.iitm.ernet.in>
References: <y49ad0yng3b.fsf@sahana.cs.iitm.ernet.in>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-84IkWT61HsBvDv9anKuo"
Organization: iNES Group
Message-Id: <1083049629.1553.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Tue, 27 Apr 2004 10:07:09 +0300
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-84IkWT61HsBvDv9anKuo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-04-27 at 10:59 +0530, rajsekar@peacock.iitm.ernet.in wrote:
> Is there a way to run some user space program / script after resuming fro=
m
> software suspend ?


Call suspend from an script.
Anything after this call will execute at resume.


--=20
Cioby


--=-84IkWT61HsBvDv9anKuo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAjgacQisRnSkd59cRAt1lAJ96TkXFoFvPs+N3nUBeoZ9vsWGVAACeM6yM
cW9h/0pS8w5s7Ax4Zd/BWWE=
=5hk6
-----END PGP SIGNATURE-----

--=-84IkWT61HsBvDv9anKuo--

