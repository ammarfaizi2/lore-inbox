Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUHTUcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUHTUcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUHTUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:32:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55200 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268729AbUHTUaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:30:52 -0400
Message-Id: <200408202030.i7KKUBbs024213@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       diablod3@gmail.com, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices 
In-Reply-To: Your message of "Fri, 20 Aug 2004 21:28:56 +0200."
             <1093030136.8998.72.camel@nosferatu.lan> 
From: Valdis.Kletnieks@vt.edu
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <4124BA10.6060602@bio.ifi.lmu.de> <1092925942.28353.5.camel@localhost.localdomain> <200408191800.56581.bzolnier@elka.pw.edu.pl> <4124D042.nail85A1E3BQ6@burner> <1092938348.28370.19.camel@localhost.localdomain> <4125FFA2.nail8LD61HFT4@burner>
            <1093030136.8998.72.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-409414180P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Aug 2004 16:30:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-409414180P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Aug 2004 21:28:56 +0200, Martin Schlemmer said:
> On Fri, 2004-08-20 at 15:41, Joerg Schilling wrote:
> > Unless you tell us what kind of "security holes" you found _and_ when this has
> > been, it looks like a meaningless remark.

> But this is the same kind of remarks you make - statements without
> proof (the ones you also did not explain, and explicitly refuse to
> explain or give a pointer to) - so I assume we should also consider
> them as meaningless ?

The difference is that Alan Cox has enough reputation that if he handwaves and
says something opaque about thinking that R/O permissions is enough to stop
something, the obvious explanations (in order of likelyhood) are:

1) He's found an actual hole, and is being intentionally obtuse until the patch
appears in the tree. (I've certainly seen *that* happen often enough, and I'm
not even what would be called an old-timer around here)..

2) It's something actually obvious, and his remark only appears opaque because
I'm an idiot and don't get it (that's been known to happen fairly often as
well).

3) He's actually full of it (much less likely than either of the first two)...


--==_Exmh_-409414180P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBJl9TcC3lWbTT17ARAihcAKDdPuKvcueBoaiP87ITe2+tYuQoVgCg4SAD
KvAxoYXqW7ooOfyEHwk6DHw=
=v0LZ
-----END PGP SIGNATURE-----

--==_Exmh_-409414180P--
