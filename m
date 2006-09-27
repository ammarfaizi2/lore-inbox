Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWI0OoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWI0OoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWI0OoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:44:23 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49869 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932431AbWI0OoW (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:44:22 -0400
Message-Id: <200609271444.k8REiDLE005062@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: vgoyal@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Stupid kexec/kdump question...
In-Reply-To: Your message of "Wed, 27 Sep 2006 09:24:20 EDT."
             <20060927132420.GB2514@in.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu> <20060926221029.d9e87650.akpm@osdl.org> <20060927052737.GA17214@verge.net.au> <m1u02toi2g.fsf@ebiederm.dsl.xmission.com> <200609271251.k8RCpp6X029724@turing-police.cc.vt.edu>
            <20060927132420.GB2514@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159368253_3224P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Sep 2006 10:44:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159368253_3224P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 Sep 2006 09:24:20 EDT, Vivek Goyal said:

> Currently we are reserving 64MB of memory for our testing purposes on 
> i386 and x86_64. Any thing lesser than that, sometimes either system
> hangs or OOM killer pitches in. Now people are working on preparing custom
> initrd for dumping purposes so that dumping can be done from early user
> space itself. This might lead to reduced memory usage and more reliability.
> I think soon it should be available in fedora (busybox based custom initrd
> for crashdumping purposes.)

I'm told the busybox-based initrd stuff has been pushed to Fedora Rawhide, but
it hasn't emerged yet - so most likely within the next 24 hours or so.  I'll
report back what happens... :)

--==_Exmh_1159368253_3224P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFGo48cC3lWbTT17ARArmmAJ0QcA2McYMDsFJpTh9pVpObT13cZACePqtL
oaP2df4Weqrl4zdcP5J2XIQ=
=RdBa
-----END PGP SIGNATURE-----

--==_Exmh_1159368253_3224P--
