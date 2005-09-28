Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVI1Qay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVI1Qay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVI1Qay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:30:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21964 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751351AbVI1Qax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:30:53 -0400
Message-Id: <200509281630.j8SGULJi022471@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: ltuikov@yahoo.com
Cc: Andre Hedrick <andre@linux-ide.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel 
In-Reply-To: Your message of "Wed, 28 Sep 2005 04:37:03 PDT."
             <20050928113703.65626.qmail@web31806.mail.mud.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050928113703.65626.qmail@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127925020_3988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Sep 2005 12:30:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127925020_3988P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Sep 2005 04:37:03 PDT, Luben Tuikov said:

> When it comes down to it SCSI Core is 20 years behind and thus Linux Storage
> is 20 years behind.

Hmm.. 20 years ago I was hooking Fujitsu Super-Eagles to Sun3/280 servers.
If you're going to claim that the current SCSI core is *that* far behind, you're
going to have to back it up.  Remember that making exaggerated claims is a good
way to make people not listen to the *rest* of your message.

Seen in include/scsi/scsi.h:

        /*
         * FIXME: bit0 is listed as reserved in SCSI-2, but is
         * significant in SCSI-3.  For now, we follow the SCSI-2
         * behaviour and ignore reserved bits.
         */

So obviously, it's at least the number of years since SCSI-3 was defined,
but no more than the time since SCSI-2.  According to http://home.comcast.net/~SCSIguy/SCSI_FAQ/scsifaq.html
SCSI-2 devices started showing up in 1988, and X3.131-1994 came out in 1994.
1996 saw the first SCSI-3 proposals.

I'll give you *one* decade, but not two. :)


--==_Exmh_1127925020_3988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDOsUccC3lWbTT17ARAvapAJ4hW/nwG/5mjFKK5J/oditAkzo/ZQCg0xop
ldhssTgPTq/4havuCRkBS30=
=RBaE
-----END PGP SIGNATURE-----

--==_Exmh_1127925020_3988P--
