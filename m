Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265003AbUEYRls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbUEYRls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUEYRlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:41:36 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:38890 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264990AbUEYRkb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:40:31 -0400
Message-Id: <200405251740.i4PHeQJY014847@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission 
In-Reply-To: Your message of "Tue, 25 May 2004 11:44:21 EDT."
             <40B369D5.7070805@timesys.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
            <40B369D5.7070805@timesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_152842466P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 May 2004 13:40:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_152842466P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 May 2004 11:44:21 EDT, "La Monte H.P. Yarroll" said:

> I THINK I have a case not covered here. I sometimes need to post unpublished
> work done by other people at my company. Since the work is not yet 
> published,
> the GPL doesn't really grant me any special rights. The authorization I use
> to publish is in fact NOT an open source license. I think clause (b) could
> probably be weakened to cover my case.

Hmm.. I'm missing something here.

It's unclear (at least to me) whether your issue is:

a) You're submitting patches that consist of GPL'able code that you don't have
the company-internal paperwork in place to authorize the release; or

b) The patches you're releasing aren't GPL'able because they're in some way
encumbered by a licensing issue.

In either case, we need to clarify and fix the problem, totally separate from
the DCO issue (all *that* does is that if somebody points out a problem with a
patch of yours down the road, we know to ask *you* about it....)


--==_Exmh_152842466P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAs4UJcC3lWbTT17ARAktMAKCV/TpHNlZhaeKE2sWokXbpNHg7RgCg5khu
2MMAlZP/bBsSixOtR4fDmns=
=/O8V
-----END PGP SIGNATURE-----

--==_Exmh_152842466P--
