Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTJWFh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 01:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJWFh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 01:37:59 -0400
Received: from h80ad268e.async.vt.edu ([128.173.38.142]:29834 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261656AbTJWFh5 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 01:37:57 -0400
Message-Id: <200310230537.h9N5b6kD010693@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Miles Bader <miles@gnu.org>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: srfs - a new file system. 
In-Reply-To: Your message of "Thu, 23 Oct 2003 14:20:21 +0900."
             <buod6cofs2y.fsf@mcspd15.ucom.lsi.nec.co.jp> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.GSO.4.44.0310070757400.4688-100000@sundance.cse.ucsc.edu> <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il> <20031022045708.GA5636@codepoet.org> <200310221605.h9MG5k37007196@turing-police.cc.vt.edu> <20031022193849.GA21188@codepoet.org>
            <buod6cofs2y.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1248839500P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Oct 2003 01:37:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1248839500P
Content-Type: text/plain; charset=us-ascii

On Thu, 23 Oct 2003 14:20:21 +0900, Miles Bader said:

> Distributed version control systems, OTOH, because they're at a somewhat
> higher level, have the huge advantage of distinct operational boundaries
> which are exposed the user and can be used to manage the distribution.
> Since users are used to these boundaries, and they usually occur at
> fairly obvious and reasonable places, this isn't such a burden on the
> users.

On the flip side, a filesystem only has to worry about who wrote which blocks
in what order.  I suspect if you tried to push the idea of a filesystem that did
the sort of intuiting of intent that BitKeeper has to do on a merge, it would
quickly get shouted down.

Unless of course somebody does BK as a Reiser4 module. :)

--==_Exmh_-1248839500P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/l2kBcC3lWbTT17ARAgCzAKCo6t6p3Tl+bszpFoANSYSvg6y8YgCgomoC
+0t9P9d+dX7lEhE1TEJNAUQ=
=HcKH
-----END PGP SIGNATURE-----

--==_Exmh_-1248839500P--
