Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUD0QRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUD0QRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUD0QRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:17:20 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:55168 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264236AbUD0QRM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:17:12 -0400
Message-Id: <200404271616.i3RGGiIr012381@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Seve Ho <sho@mailprove.com>
Cc: Arthur Perry <kernel@linuxfarms.com>, linux-kernel@vger.kernel.org
Subject: Re: mkinitrd error 
In-Reply-To: Your message of "Tue, 27 Apr 2004 11:36:21 +0800."
             <408DD535.80507@mailprove.com> 
From: Valdis.Kletnieks@vt.edu
References: <408CDBF1.90301@mailprove.com> <Pine.LNX.4.58.0404261005210.8600@tiamat.perryconsulting.net>
            <408DD535.80507@mailprove.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2146400652P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Apr 2004 12:16:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2146400652P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Apr 2004 11:36:21 +0800, Seve Ho <sho@mailprove.com>  said:

>  # make mrproper
>  # cd /usr/src/linux-2.4/configs
>  # cp kernel-2.4.18-ia64-smp.config  /usr/src/linux-2.4/.config
>  # make oldconfig

Are we missing a 'cd /usr/src/linux-2.4' in here?

--==_Exmh_2146400652P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAjodrcC3lWbTT17ARAkGqAKCt4Osmiwm3d8LyrdJFxN3Nzyyw0wCg1q4K
iAStcBwHaskWeNpBa0wc1Qw=
=pcIu
-----END PGP SIGNATURE-----

--==_Exmh_2146400652P--
