Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752014AbWCPC41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbWCPC41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWCPC41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:56:27 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:944 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1752014AbWCPC40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:56:26 -0500
Message-Id: <200603160255.k2G2tsUv007226@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Grant Coady <gcoady@gmail.com>, Willy Tarreau <willy@w.ods.org>,
       Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Which kernel is the best for a small linux system? 
In-Reply-To: Your message of "Wed, 15 Mar 2006 23:53:21 +0100."
             <Pine.LNX.4.61.0603152347210.20859@yvahk01.tjqt.qr> 
From: Valdis.Kletnieks@vt.edu
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com> <1142273212.3023.35.camel@laptopd505.fenrus.org> <20060314062144.GC21493@w.ods.org> <kv2d12131e73fjkp0hufomj152un5tbsj1@4ax.com> <20060314222131.GB3166@flint.arm.linux.org.uk>
            <Pine.LNX.4.61.0603152347210.20859@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142477754_5420P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 21:55:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1142477754_5420P
Content-Type: text/plain; charset=us-ascii

On Wed, 15 Mar 2006 23:53:21 +0100, Jan Engelhardt said:

> Although the exact numbers of patches per time for a specific 
> software manufacturer - let's pick Microsoft as an example - is not known, 
> it is usually low (two for this *month* afaics), compared to what hits lkml 
> *each day*.
> 
> Does that make their software more stable than Linux? I would have my 
> doubts about that.

You have doubts, because it's a totally b0rken metric. ;)

(Incidentally, there is some pretty good evidence in the computer security
community that although Microsoft has *announced* two patches for this month,
that actually there's code tweaks for *other* un-admitted problems as well.
Careful dissection of the patches often finds them poking in parts of the
operating system far removed from where the obvious problem is - so there
could possibly be a dozen or more *actual* fixes in those two patches..)

A better comparison would be the number of things on lkml *per day*,
compared to the number of issues reported *internal to Microsoft* *per day*.

Or do the comparison after trimming out all the lkml code cleanups and fixes
for obscure corner cases that often seem to only be afflicting one or two
users on the entire planet (I know I've reported my share of those types ;)

The main reason the lkml traffic is so high is because we dissect and argue
almost every single line of code in public before it goes in-tree..

--==_Exmh_1142477754_5420P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEGNO6cC3lWbTT17ARApxCAJ9MpLSbYgn110YtLHfZ6McJPUH7fQCg5aQz
ztRZz80ubWEVeZ7XnsMIacI=
=FBol
-----END PGP SIGNATURE-----

--==_Exmh_1142477754_5420P--
