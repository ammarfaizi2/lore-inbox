Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbVIOUUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVIOUUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbVIOUUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:20:04 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:18839 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S1161008AbVIOUUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:20:03 -0400
Message-Id: <200509152019.j8FKJvAD025249@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Joe Bob Spamtest <joebob@spamtest.viacore.net>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: HZ question 
In-Reply-To: Your message of "Thu, 15 Sep 2005 09:16:25 PDT."
             <43299E59.4060103@spamtest.viacore.net> 
From: Valdis.Kletnieks@vt.edu
References: <4326CAB3.6020109@compro.net> <2cd57c9005091321006825540@mail.gmail.com> <1126747237.13893.108.camel@mindpipe>
            <43299E59.4060103@spamtest.viacore.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126815596_3148P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Sep 2005 16:19:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126815596_3148P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Sep 2005 09:16:25 PDT, Joe Bob Spamtest said:
> Lee Revell wrote:
> > On Wed, 2005-09-14 at 12:00 +0800, Coywolf Qi Hunt wrote:
> > 
> >>simply zgrep HZ= /proc/config.gz
> >>on my box, I get CONFIG_HZ=1000
> > 
> > 
> > Many distros inexplicably disable that by default.
> 
> Their rationale is that knowing the kernel .config is a security threat. 

At least in Fedora, they ship a mode 644 config file in /boot:

% ls -l /boot/config-2.6.13-1.1555_FC5
61 -rw-r--r--  1 root root 60135 Sep 14 15:55 /boot/config-2.6.13-1.1555_FC5

No need to include that in the kernel if it's right there on disk.  Even Fedora
doesn't believe in *that* much bloat. ;)

--==_Exmh_1126815596_3148P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDKddscC3lWbTT17ARAmAUAJ4oOmC5DX0SoH7DjvuA5MtYKui8+wCfUgXw
caf5cEp3TUltiBDOJRLwBXA=
=aq/G
-----END PGP SIGNATURE-----

--==_Exmh_1126815596_3148P--
