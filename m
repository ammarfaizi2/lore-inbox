Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTLaSPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTLaSPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:15:05 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13192 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265223AbTLaSPB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:15:01 -0500
Message-Id: <200312311814.hBVIEnA3006253@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] un-document not yet merged CFQ io-scheduler 
In-Reply-To: Your message of "Tue, 30 Dec 2003 13:04:48 +0100."
             <Pine.LNX.4.53.0312301301350.27176@gockel.physik3.uni-rostock.de> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.53.0312301301350.27176@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1002711831P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Dec 2003 13:14:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1002711831P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 Dec 2003 13:04:48 +0100, Tim Schmielau said:
> The CFQ io-scheduler isn't yet merged, thus it seems a bit too early 
> to document it.

Yes, I submitted that patch not realizing that CFQ was a -mm feature,
and that patch should probably be carried along with the rest of the CFQ code.

--==_Exmh_-1002711831P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/8xIZcC3lWbTT17ARAviNAJwIw62nhDuIrSqmMw8QF8TjfwJ5FACeKizt
JqaR42aE7+2MfJHlOQeifMg=
=93n9
-----END PGP SIGNATURE-----

--==_Exmh_-1002711831P--
