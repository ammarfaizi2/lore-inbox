Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbTALUnC>; Sun, 12 Jan 2003 15:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbTALUnB>; Sun, 12 Jan 2003 15:43:01 -0500
Received: from h80ad26bd.async.vt.edu ([128.173.38.189]:20864 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267407AbTALUnA>; Sun, 12 Jan 2003 15:43:00 -0500
Message-Id: <200301122051.h0CKpbWN004621@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*? 
In-Reply-To: Your message of "Sun, 12 Jan 2003 20:32:01 GMT."
             <6uk7haxg72.fsf@zork.zork.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com> <1042401596.1209.51.camel@RobsPC.RobertWilkens.com> <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
            <6uk7haxg72.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1762036992P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jan 2003 15:51:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1762036992P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jan 2003 20:32:01 GMT, Sean Neakums <sneakums@zork.net>  said:
> commence  Valdis.Kletnieks@vt.edu quotation:
> 
> > The real problem is that C doesn't have a good multi-level "break"
> > construct.  On the other hand, I don't know of any language that has
> > a good one - some allow "break 3;" to break 3 levels- but that's
> > still bad because you get screwed if somebody adds an 'if'
> > clause....
> 
> Perl's facility for labelling blocks and jumping to the beginning or
> end with 'next' and 'last' may be close to what you want, but I don't
> know if it's ever been implemented in a language one could sensibly
> use to write a kernel.

Hmm.. I'm not a Perl wizard.. <reads the docs> Yeah, that's what I meant,
and no, that's not a sane kernel language. ;)

--==_Exmh_1762036992P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IdVYcC3lWbTT17ARApF7AJ95nJEHAsNukmubSS+es7E/NOErhACgjUnE
GiyYgkQos9qj5IDD1EiXMXk=
=TMxr
-----END PGP SIGNATURE-----

--==_Exmh_1762036992P--
