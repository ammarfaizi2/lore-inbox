Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbUL3Fqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUL3Fqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 00:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUL3Fqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 00:46:47 -0500
Received: from h80ad2496.async.vt.edu ([128.173.36.150]:24206 "EHLO
	h80ad2496.async.vt.edu") by vger.kernel.org with ESMTP
	id S261544AbUL3Fqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 00:46:45 -0500
Message-Id: <200412300546.iBU5kVie023979@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: Is CAP_SYS_ADMIN checked by every program !? 
In-Reply-To: Your message of "Thu, 30 Dec 2004 00:35:06 EST."
             <9033584D-5A24-11D9-989E-000393ACC76E@mac.com> 
From: Valdis.Kletnieks@vt.edu
References: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
            <9033584D-5A24-11D9-989E-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2020062340P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Dec 2004 00:46:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2020062340P
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Dec 2004 00:35:06 EST, Kyle Moffett said:

> Yes, whenever anything on the computer, including the kernel, checks if 
> a program
> has a capability bit set, it will print out whether or not it does in 
> the dmesg.  Why
> does that matter?

If you actually log your kernel messages it can matter, if every single
process suddenly starts dumping a line in your syslogs, especially on a
busy system...

--==_Exmh_2020062340P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB05Y2cC3lWbTT17ARAiNNAKCZCfGirKjEbfewv4lrRd80TqFBrwCgi+x6
3FSQkmEOz5rJchuuNpALdGc=
=hgXL
-----END PGP SIGNATURE-----

--==_Exmh_2020062340P--
