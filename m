Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTDNPMt (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTDNPMt (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:12:49 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:44673 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263426AbTDNPMs (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 11:12:48 -0400
Date: Mon, 14 Apr 2003 16:24:35 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using devfs on 2.4
Message-ID: <20030414152435.GB6820@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Michael Buesch <fsdeveloper@yahoo.de>, linux-kernel@vger.kernel.org
References: <200304141657.26983.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <200304141657.26983.fsdeveloper@yahoo.de>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir eternal.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2003 at 04:57:26PM +0200, Michael Buesch wrote:
> Is it save and well supported to run devfs on 2.4.21-preX ?

   I think asking if devfs is safe round here is probably a bad
idea. You might get an answer. At length. :)

   However, it works for me (2.4.21-pre5-ac3), and has worked for many
previous versions of 2.4.

> Do all drivers support devfs?

   I've not met one which doesn't, but then I don't have lots of
hardware to test on.

> Or should I wait for 2.6?

   The udev stuff in 2.6 looks like it might become very nice indeed,
but you don't have to wait for that to use devfs.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- Hey, Virtual Memory! Now I can have a *really big* ramdisk! ---   

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mtKzssJ7whwzWGARAppVAJ0btikx1dx7IFpX2cR6ea0odToOCwCeJDE/
O9IfAGe8fxomAIm4KS8tEoE=
=6F16
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
