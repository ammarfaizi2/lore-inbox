Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWDSRGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWDSRGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWDSRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:06:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9622 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751061AbWDSRGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:06:53 -0400
Message-Id: <200604191700.k3JH0H5M011894@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks) 
In-Reply-To: Your message of "Wed, 19 Apr 2006 10:16:46 +0200."
             <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> 
From: Valdis.Kletnieks@vt.edu
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com>
            <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145466017_2985P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Apr 2006 13:00:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145466017_2985P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Apr 2006 10:16:46 +0200, Jan Engelhardt said:

> >So, I think the only way to be able to realisticly keep the LSM
> >interface, is for a valid, working, maintained LSM-based security model
> >to go into the kernel tree.  So far, I haven't seen any public posting
> >of patches that meet this requirement :(
> 
> In that case, maybe it would be worthwhile to flip the positions, i.e. LSM on
> top of SELinux, sort of a compat layer.

How would that *possibly* work?  What semantics would *that* have?


--==_Exmh_1145466017_2985P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERmyhcC3lWbTT17ARAmwbAJ4wFHD8UGc9beKPKoWa6MXKpKplcQCdFp0L
8UlLFg9dZpb02Mt1151WZSU=
=gGey
-----END PGP SIGNATURE-----

--==_Exmh_1145466017_2985P--
