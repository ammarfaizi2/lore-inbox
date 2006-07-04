Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWGDTai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWGDTai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWGDTai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:30:38 -0400
Received: from pool-72-66-194-43.ronkva.east.verizon.net ([72.66.194.43]:27587
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932346AbWGDTah (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:30:37 -0400
Message-Id: <200607041930.k64JUOrJ000590@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Theodore Tso <tytso@mit.edu>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
In-Reply-To: Your message of "Mon, 03 Jul 2006 21:02:40 EDT."
             <20060704010240.GD6317@thunk.org>
From: Valdis.Kletnieks@vt.edu
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
            <20060704010240.GD6317@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152041424_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 15:30:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152041424_4949P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jul 2006 21:02:40 EDT, Theodore Tso said:

> So such a scheme would only be used when some Ph.D. student has ten
> years of thesis research on a disk with no backups and then
> accidentally runs mkfs on the wrong partition.....  of course, one
> could argue that such a stupid student doesnt *deserve* to get a Ph.D.  :-)

The more common use case is a department hires a grad student to run the
department server rather than somebody who knows what they're doing (but
costs more than a grad student stipend), and said grad student first sets
up a borked backup scheme that looks like it works, but doesn't actually
produce restorable backups, and then runs mkfs on /home, nuking all the
thesis work of all the students....

(And yes, I've seen that more than once in a quarter century of working
at .edu's... ;)

--==_Exmh_1152041424_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqsHQcC3lWbTT17ARAqsIAKDeRHSm5oxX6XYbCoo6difxElciLwCeJIUR
YlCl3IrsaUU3dMVUw2Ml/4Y=
=xTL5
-----END PGP SIGNATURE-----

--==_Exmh_1152041424_4949P--
