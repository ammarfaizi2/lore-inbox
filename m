Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWGXSaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWGXSaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWGXSaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:30:14 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17322 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751378AbWGXSaM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:30:12 -0400
Message-Id: <200607241828.k6OISdHq014568@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Mike Benoit <ipso@snappymail.ca>, Hans Reiser <reiser@namesys.com>,
       lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
In-Reply-To: Your message of "Mon, 24 Jul 2006 19:35:24 +0200."
             <44C504DC.6080907@gmx.de>
From: Valdis.Kletnieks@vt.edu
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com> <20060724102508.GA26553@merlin.emma.line.org> <1153760245.5735.47.camel@ipso.snappymail.ca>
            <44C504DC.6080907@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153765719_3460P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jul 2006 14:28:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153765719_3460P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Jul 2006 19:35:24 +0200, Matthias Andree said:
> Mike Benoit wrote:
> 
> > I've been bitten by running out of inodes on several occasions, and by
> > switching to ReiserFS it saved one company I worked for over $250,000
> > because they didn't need to buy a totally new piece of software.
> 
> ext3fs's inode density is configurable, reiserfs's hash overflow chain
> length is not, and it doesn't show in df -i either.

Equally important - you can usually *see* "out of inodes" coming on a 'df -i'
long before a reiser3 filesystem hits the wall on a hash issue.

--==_Exmh_1153765719_3460P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFExRFXcC3lWbTT17ARAuFrAKCZMgezkVvb0c9PWOmUJDaOEZO9gQCdGE1/
UwKKZ8n+RS27xTBde0kL6qk=
=R2kD
-----END PGP SIGNATURE-----

--==_Exmh_1153765719_3460P--
