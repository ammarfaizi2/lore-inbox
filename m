Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbTATUX4>; Mon, 20 Jan 2003 15:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbTATUX4>; Mon, 20 Jan 2003 15:23:56 -0500
Received: from h80ad2471.async.vt.edu ([128.173.36.113]:36507 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266730AbTATUXz>; Mon, 20 Jan 2003 15:23:55 -0500
Message-Id: <200301202032.h0KKWrIJ023544@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: David Schwartz <davids@webmaster.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is the BitKeeper network protocol documented? 
In-Reply-To: Your message of "Mon, 20 Jan 2003 11:43:48 PST."
             <20030120194430.AAA20700%shell.webmaster.com@whenever> 
From: Valdis.Kletnieks@vt.edu
References: <20030120194430.AAA20700%shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_820136708P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Jan 2003 15:32:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_820136708P
Content-Type: text/plain; charset=us-ascii

On Mon, 20 Jan 2003 11:43:48 PST, David Schwartz said:

> 	Checking source code out of a repository is an obfuscatory act that 
> separates the raw source code from the rationale for that source 
> code. It's equivalent to stripping comments. The GPL does not allow 

So is shipping the source without the transcript of the kernel developer's
conference, because then you're stripping out some of the design rationale.

So is shipping the source without a neuron dump of the programmer - let's face
it, we've ALL looked at code and said "What WERE they thinking?", and therefor
a neuron dump would be part of the *preferred* format.

You seem determined to obfuscate the issue by confusing the *SOURCE* that
actually gets modified, and metainformation used to keep TRACK of the source.

Quick sanity test:

Do people actually modify the BK repository, or do they check it out
so they can actually modify *THE CHECKED OUT TREE*?  Last I heard, people
actually did edits on the source tree, and they used gcc (or whatever compiler)
on the source tree.  Then they make diffs between the old tree and new tree
and send them to Linus.

Seems to *ME* that since almost all of the source code was actually
created in a '(vi|emacs) / make / gcc / diff' environment, that is the
PREFERRED format for making modifications.

Don't confuse the source tree with metainformation, or you'll end up having
to carry around inode information.  Lest you think I'm joking, consider the
fact that the original Crowther&Woods Adventure game was called 'ADVENT.FOR',
and the case and number of chars was actually significant information....




--==_Exmh_820136708P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+LFz0cC3lWbTT17ARAnTaAKDwwsOXbkUmxcKK6SWKep0L7WyRkACgp+KL
X8D78Zl1Ff3GrPe1KJwCTF4=
=YLYP
-----END PGP SIGNATURE-----

--==_Exmh_820136708P--
