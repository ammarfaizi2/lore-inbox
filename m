Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbUBFU4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUBFU4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:56:39 -0500
Received: from h80ad2445.async.vt.edu ([128.173.36.69]:36998 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265584AbUBFU4i (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:56:38 -0500
Message-Id: <200402062056.i16KuVS6020404@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ? 
In-Reply-To: Your message of "Fri, 06 Feb 2004 17:09:17 -0300."
             <20040206170917.E18820@almesberger.net> 
From: Valdis.Kletnieks@vt.edu
References: <20040206041223.A18820@almesberger.net> <20040206183746.GR4902@ca-server1.us.oracle.com>
            <20040206170917.E18820@almesberger.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1834550369P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Feb 2004 15:56:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1834550369P
Content-Type: text/plain; charset=us-ascii

On Fri, 06 Feb 2004 17:09:17 -0300, Werner Almesberger <wa@almesberger.net>  said:

> Hmm, "all, but the f_pos read-modify-write" sounds more like how
> an insurance company would define "all" :-)
> 
> What's puzzling here is that the standard would introduce such an
> important concept in the discussion of threads.

Well... it's the sort of problem that's very Schrodenger unless you have
another thread/process observing.

--==_Exmh_-1834550369P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAI/9/cC3lWbTT17ARAueGAKCsWuAgFNQGQ4XCdPOi80CirD8wfACgyjKR
GtvGp07PsCP6PI6zG6nlTIM=
=hv93
-----END PGP SIGNATURE-----

--==_Exmh_-1834550369P--
