Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965620AbVKHAIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965620AbVKHAIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965618AbVKHAIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:08:00 -0500
Received: from smtp06.auna.com ([62.81.186.16]:38547 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S965613AbVKHAH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:07:59 -0500
Date: Tue, 8 Nov 2005 01:07:08 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051108010708.46a6f577@werewolf.auna.net>
In-Reply-To: <20051107224307.698da24b@werewolf.auna.net>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F2452.9020207@reub.net>
	<20051107020905.69c0b6dc.akpm@osdl.org>
	<17263.11214.992300.34384@cse.unsw.edu.au>
	<20051107023723.5cf63393.akpm@osdl.org>
	<436F3020.1040209@reub.net>
	<20051107105257.333248c0.akpm@osdl.org>
	<20051107224307.698da24b@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 1.9.99cvs17 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_t3ON29Ui/5rogOV+wFFbL/y";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Tue, 8 Nov 2005 01:07:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_t3ON29Ui/5rogOV+wFFbL/y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Nov 2005 22:43:07 +0100, "J.A. Magallon" <jamagallon@able.es> wro=
te:

> On Mon, 7 Nov 2005 10:52:57 -0800, Andrew Morton <akpm@osdl.org> wrote:
>=20
> > Reuben Farrelly <reuben-lkml@reub.net> wrote:
> > >
> > >  Debug: sleeping function called from invalid context at include/asm/=
semaphore.h:99
> > >  in_atomic():1, irqs_disabled():1
> > >    [<c0103c46>] dump_stack+0x17/0x19
>

Any idea on this ? It kills my raid box in a couple minutes... ;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_t3ON29Ui/5rogOV+wFFbL/y
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDb+wsRlIHNEGnKMMRAs8iAJ9+4r6sDYSSfoqwJGdEDOgKVGYi9ACdGQ3p
Q5bZR6sBUF3mD+o9XudvFBA=
=JzV2
-----END PGP SIGNATURE-----

--Sig_t3ON29Ui/5rogOV+wFFbL/y--
