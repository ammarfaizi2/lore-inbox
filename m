Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbUBDDLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 22:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUBDDLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 22:11:39 -0500
Received: from h80ad267b.async.vt.edu ([128.173.38.123]:8320 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266160AbUBDDLg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 22:11:36 -0500
Message-Id: <200402040311.i143B6MH004923@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Clay Haapala <chaapala@cisco.com>, Matt Mackall <mpm@selenic.com>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines 
In-Reply-To: Your message of "Tue, 03 Feb 2004 17:25:08 CST."
             <20040203172508.B26222@lists.us.dell.com> 
From: Valdis.Kletnieks@vt.edu
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com> <20040203185111.GA31138@waste.org> <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com>
            <20040203172508.B26222@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1796142259P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Feb 2004 22:11:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1796142259P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 Feb 2004 17:25:08 CST, Matt Domsch said:

> /*
>  * This code is in the public domain; copyright abandoned.
>  * Liability for non-performance of this code is limited to the amount
>  * you paid for it.  Since it is distributed for free, your refund will
>  * be very very small.  If it breaks, you get to keep both pieces.
>  */

Hmm.. I could have *sworn* that abandoning something to the public
domain prohibited any disclaimer-of-liability clauses - the original
reason for the MIT X copyright was because they couldn't disclaim
liability if they let it into the public domain.  It's the same basic
"by copying, you agree to our terms" copyright that essentially all
open-source depends on.

And if it's in the public domain, they don't have to agree to your terms,
and thus you can't enforce that liability disclaimer..

Smells fishy, needs to be looked at by an actual copyright expert.

--==_Exmh_1796142259P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIGLJcC3lWbTT17ARAsoGAKCSIE0CS8sDJnmGytXMt5w4l5taHQCg5xwX
+Z23qYFjGcBON7TTZbtoU+Q=
=JWO6
-----END PGP SIGNATURE-----

--==_Exmh_1796142259P--
