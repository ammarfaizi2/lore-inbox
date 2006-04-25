Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWDYSfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWDYSfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWDYSfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:35:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16340 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932286AbWDYSfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:35:01 -0400
Message-Id: <200604251834.k3PIYTS9006648@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Neil Brown <neilb@suse.de>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview 
In-Reply-To: Your message of "Tue, 25 Apr 2006 12:45:33 EDT."
             <1145983533.21399.56.camel@moss-spartans.epoch.ncsc.mil> 
From: Valdis.Kletnieks@vt.edu
References: <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <20060424070324.GA14720@thunk.org> <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil> <20060424235215.GA5893@thunk.org>
            <1145983533.21399.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145990069_2618P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 14:34:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145990069_2618P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 Apr 2006 12:45:33 EDT, Stephen Smalley said:

> pam_namespace in Fedora Core.  Not to mention that the restrictions you
> mention only solve the problem within the jail, which is fine if we are
> only talking about jail mechanisms.  Not so good for any kind of real
> MAC.

Umm.. Stephen? Where in Fedora Core is it?  I'm running a Fedora Core Rawhide
right now, and it's not on my system, and 'yum provides pam_namespace.so'
doesn't find it either.  There *is* stuff over in the -lspp branch, but it
(AFAIK) hasn't escaped into anything resembling general availability.  Was this
what you were referencing?

--==_Exmh_1145990069_2618P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETmu1cC3lWbTT17ARAtGkAJ0agSndBqPwwQqRrSUnjcWFARcO6ACgpzka
ibyq38GTkRml1sSDBsiaswM=
=Xm/3
-----END PGP SIGNATURE-----

--==_Exmh_1145990069_2618P--
