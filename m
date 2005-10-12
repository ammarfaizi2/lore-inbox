Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVJLUNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVJLUNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJLUNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:13:36 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32196 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932440AbVJLUNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:13:35 -0400
Message-Id: <200510122013.j9CKDVGV032270@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Klaus Dittrich <kladit@arcor.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc* / xinetd 
In-Reply-To: Your message of "Wed, 12 Oct 2005 20:27:00 +0200."
             <434D5574.10405@arcor.de> 
From: Valdis.Kletnieks@vt.edu
References: <20051012143657.GA1625@xeon2.local.here> <200510121745.j9CHj6XE023497@turing-police.cc.vt.edu>
            <434D5574.10405@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1129148011_16609P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Oct 2005 16:13:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1129148011_16609P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 Oct 2005 20:27:00 +0200, Klaus Dittrich said:

> service time
> {
>     type        = INTERNAL
>     id          = dgram_time

That, my friends, is UDP port 37, not UDP port 123 where NTP lives.


--==_Exmh_1129148011_16609P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDTW5rcC3lWbTT17ARAhrJAJ0ek2v1QmPhv3wHdc9xZUkaDDFVHACfWPVs
t8j5Vi+93AkzH3fVlfUt8y0=
=mo/v
-----END PGP SIGNATURE-----

--==_Exmh_1129148011_16609P--
