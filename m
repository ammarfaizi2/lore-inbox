Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTGBSM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTGBSM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:12:57 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10624 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261985AbTGBSMv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:12:51 -0400
Message-Id: <200307021827.h62IRCp3001341@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3 
In-Reply-To: Your message of "Tue, 01 Jul 2003 20:38:30 PDT."
             <20030701203830.19ba9328.akpm@digeo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030701203830.19ba9328.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1586579328P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jul 2003 14:27:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1586579328P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jul 2003 20:38:30 PDT, Andrew Morton <akpm@digeo.com>  said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm3/

> . The weird behaviour with time-n-date on SpeedStep machines should be
>   fixed.  Some of the weird behaviour, at least.

The problem I noted with speedstep-ich.c mangling the loops_per_jiffies variable
is still there.  Looks like I have something to do on the plane tomorrow. ;)

--==_Exmh_-1586579328P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/AyQAcC3lWbTT17ARAglgAJwOL6q4f3d1kactDN3RMgNG+/tZjgCcCuVX
wV8bHEEyPDh1eLWHftdIDzE=
=nzKV
-----END PGP SIGNATURE-----

--==_Exmh_-1586579328P--
