Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWDYTxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWDYTxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWDYTxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:53:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50049 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751352AbWDYTxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:53:08 -0400
Message-Id: <200604251952.k3PJqj2J010248@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nix <nix@esperi.org.uk>, Axelle Apvrille <axelle_apvrille@yahoo.fr>,
       drepper@gmail.com, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries 
In-Reply-To: Your message of "Tue, 25 Apr 2006 21:37:48 +0200."
             <1145993869.3114.38.camel@laptopd505.fenrus.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <1145984201.3114.34.camel@laptopd505.fenrus.org> <878xpto53w.fsf@hades.wkstn.nix>
            <1145993869.3114.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145994765_2618P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 15:52:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145994765_2618P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 Apr 2006 21:37:48 +0200, Arjan van de Ven said:
> On Tue, 2006-04-25 at 19:57 +0100, Nix wrote:
> > On Tue, 25 Apr 2006, Arjan van de Ven said:
> > > On Tue, 2006-04-25 at 18:11 +0200, Axelle Apvrille wrote:
> > >> - finally, note you also have choice not to sign this
> > >> elf loader of yours. If it isn't signed, it won't ever
> > >> run ;-)
> > > 
> > > so you didn't sign perl ? or bash ?
> > 
> > You can write an elf loader in bash?!
> 
> I've not tried it.. but afaics bash scripts are sufficiently turing
> complete to pull it off ;)

Well, somebody did 'shasm' (an assembler in bash), so I don't see any reason
you can't do an elf loader... (OK, so you *might* have to write a machine
emulator in bash, store the binary in an array, and emulate the sucker...)

--==_Exmh_1145994765_2618P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETn4NcC3lWbTT17ARAsvLAKDr3svKFB/Ir+eijppiWaTSgKclKgCgpfu4
ugL5wLbRlobEyP39YkLv170=
=KZoQ
-----END PGP SIGNATURE-----

--==_Exmh_1145994765_2618P--
