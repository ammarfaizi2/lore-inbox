Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVEQU2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVEQU2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVEQU2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:28:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:58382 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261922AbVEQU1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:27:55 -0400
Message-Id: <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Karel Kulhavy <clock@twibright.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa 
In-Reply-To: Your message of "Tue, 17 May 2005 21:24:12 +0200."
             <20050517192412.GA19431@kestrel.twibright.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050517095613.GA9947@kestrel> <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel> <1116354762.31830.12.camel@mindpipe>
            <20050517192412.GA19431@kestrel.twibright.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116361664_5349P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 May 2005 16:27:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116361664_5349P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 May 2005 21:24:12 +0200, Karel Kulhavy said:
> Lee Revell wrote:
> 
> > Finally, these questions are all OT for LKML.  Try alsa-user at
> > lists.sf.net and alsa-devel at lists.sf.net.  Also there's a bug
> 
> ALSA is a part of Linux kernel, right? This is linux-kernel. Why
> is it OT here? Doesn't make sense for me.

I was hoping somebody would explain how to get 'dmix' plugin working in the
kernel - then I could get rid of esd ;)  (Note that running something in
userspace that accepts connections, runs dmix on them, and then creates one
thing spewing to /dev/pcm isn't a solution - I've already *got* esd, warts and all)

--==_Exmh_1116361664_5349P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCilPAcC3lWbTT17ARAjSEAJsHDlffl89lbxjN5+Ll24bT6h+3SACgmG2+
9irInz5eeM0T3sdydriWXGE=
=HFsa
-----END PGP SIGNATURE-----

--==_Exmh_1116361664_5349P--
