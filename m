Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVAGXhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVAGXhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVAGXh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:37:29 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53262 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261714AbVAGXek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:34:40 -0500
Message-Id: <200501072334.j07NYAZB025546@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/04/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       arjanv@redhat.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-Reply-To: Your message of "Fri, 07 Jan 2005 15:20:04 PST."
             <20050107152004.0f8c488e.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <200501072207.j07M7Lda004987@turing-police.cc.vt.edu> <20050107143638.L2357@build.pdx.osdl.net> <200501072301.j07N1TW2027950@turing-police.cc.vt.edu>
            <20050107152004.0f8c488e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1105140850_12694P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jan 2005 18:34:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1105140850_12694P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jan 2005 15:20:04 PST, Andrew Morton said:

> Does anyone actually have a handle on what's involved in fixing the
> inheritance problem?

Andy Lutomirski was looking at that, and it's actually a very small but
incompatible change that allows filesystem support for set-capability files to
be actually usable.  He posted some patches back in May....

--==_Exmh_1105140850_12694P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB3xxycC3lWbTT17ARArrsAKClK5zyeqSM0gUJL6n/7SktFZgpYACgow+P
kVkbgvo7xsEmrydq5G9VCKo=
=WqUH
-----END PGP SIGNATURE-----

--==_Exmh_1105140850_12694P--
