Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUIOWwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUIOWwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUIOWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:52:16 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:19156 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267739AbUIOWu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:50:29 -0400
Date: Thu, 16 Sep 2004 00:48:59 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: taeuber@informatik.hu-berlin.de, lars.taeuber@gmx.net, axboe@suse.de,
       linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: cdrom recognition on kernel 2.6.8.1
Message-ID: <20040915224859.GB26458@thundrix.ch>
References: <20040915093635.1a8f08ff.taeuber@bbaw.de> <20040915085939.GU2304@suse.de> <20040915191532.246dc6ca.lars.taeuber@gmx.net> <20040915200311.5c8b2c83.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20040915200311.5c8b2c83.Ballarin.Marc@gmx.de>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Sep 15, 2004 at 08:03:11PM +0200, Marc Ballarin wrote:
> I've seen Teac drives blocking the Windows XP boot process when
> certain discs are inserted. There were even freezes when copying files to
> hard disk that did not occur when a different drive was used.
> (Wasn't my machine, can't test anything.)

I've  had some  issues  with an  old  TEAC SCSI  CD  writer which  was
somewhat weird:

On bootup it  would only read CDs if, after  bootup had completed, one
switched  off its  power  and booted  it  again. (SCSI  RESET was  not
sufficient.)

So yes.

			    Tonnerre

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBSMba/4bL7ovhw40RAh7BAKCPWdUqwFoPD9m6HXYk2lUhgN0LTgCgoaSu
IZ2bSjnKRLZpChGVR3nWysI=
=ueVR
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
