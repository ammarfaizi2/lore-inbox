Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVBIRox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVBIRox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVBIRox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:44:53 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4873 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261864AbVBIRot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:44:49 -0500
Message-Id: <200502091744.j19HiWtd011559@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Nicolas Pitre <nico@cam.org>
Cc: Larry McVoy <lm@bitmover.com>, Alexandre Oliva <aoliva@redhat.com>,
       Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto 
In-Reply-To: Your message of "Wed, 09 Feb 2005 12:30:54 EST."
             <Pine.LNX.4.61.0502091219430.7836@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet> <20050204201157.GN27707@bitmover.com> <20050204214015.GF5028@deep-space-9.dsnet> <20050204233153.GA28731@electric-eye.fr.zoreil.com> <20050205193848.GH5028@deep-space-9.dsnet> <20050205233841.GA20875@bitmover.com> <20050208154343.GH3537@crusoe.alcove-fr> <20050208155845.GB14505@bitmover.com> <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br> <20050209155113.GA10659@bitmover.com>
            <Pine.LNX.4.61.0502091219430.7836@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107971071_3925P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Feb 2005 12:44:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107971071_3925P
Content-Type: text/plain; charset=us-ascii

On Wed, 09 Feb 2005 12:30:54 EST, Nicolas Pitre said:

> If I don't want to use a certain filesystem, I mount it and copy the 
> files over to another filesystem.  What users are interested in are the 
> files themselves of course, and the efficiency with which the filesystem 
> handles those files.

That's Larry's point exactly - you don't care (or shouldn't, unless you're
writing a competing product) any more about the BK internal metadata than
you should care about how ext3 handles the journal or the free list.

--==_Exmh_1107971071_3925P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCCkv+cC3lWbTT17ARAkwOAJ4hbhvkQQPJGx+AiFgjuUxNKuup0ACfegtl
sdfPN2MLL0aZS5RL30q5PeA=
=n9Kr
-----END PGP SIGNATURE-----

--==_Exmh_1107971071_3925P--
