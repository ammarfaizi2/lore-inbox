Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTINW15 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 18:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTINW14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 18:27:56 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:18659 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262009AbTINW1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 18:27:47 -0400
Date: Sun, 14 Sep 2003 23:27:36 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: libata update posted
Message-ID: <20030914222736.GA29560@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <3F628DC7.3040308@pobox.com> <20030913211332.GC3478@werewolf.able.es> <20030913213828.GC21426@gtf.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20030913213828.GC21426@gtf.org>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 13, 2003 at 05:38:28PM -0400, Jeff Garzik wrote:
> No user documentation, but feel free to ask me questions.  Here's a
> quick overview:
> 
> ata_piix, ata_via -- low-level driver modules
> libata -- shared code module for the above

   Do you have any plans to support SiI3112 in libata? The current
SiI3112 drivers in the kernel just don't seem to work right on my
hardware. :(

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
  --- I am but mad north-north-west:  when the wind is southerly, I ---  
                       know a hawk from a handsaw.                       

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ZOtXssJ7whwzWGARAnOVAJ4nrsHCPi3fvTrFYZRerbAQWzUnBQCfcFn3
aAGu2sPDAnoCU1guy150SJw=
=gTMG
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
