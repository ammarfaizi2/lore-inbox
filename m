Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTBCSsM>; Mon, 3 Feb 2003 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbTBCSsM>; Mon, 3 Feb 2003 13:48:12 -0500
Received: from h80ad247a.async.vt.edu ([128.173.36.122]:10891 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266978AbTBCSsL>; Mon, 3 Feb 2003 13:48:11 -0500
Message-Id: <200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: John Bradford <john@grabjohn.com>
Cc: assembly@gofree.indigo.ie (Seamus), linux-kernel@vger.kernel.org
Subject: Re: CPU throttling?? 
In-Reply-To: Your message of "Mon, 03 Feb 2003 17:13:02 GMT."
             <200302031713.h13HD2K8000181@darkstar.example.net> 
From: Valdis.Kletnieks@vt.edu
References: <200302031713.h13HD2K8000181@darkstar.example.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_180667911P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Feb 2003 13:57:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_180667911P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Feb 2003 17:13:02 GMT, John Bradford said:

> Incidently, Linux has always halted the processor, rather than spun in
> an idle loop, which saves power.

It's conceivable that a CPU halted at 1.2Gz takes less power than one
at 1.6Gz - anybody have any actual data on this?  Alternately phrased,
does CPU throttling save power over and above what the halt does?
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_180667911P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+PruNcC3lWbTT17ARAinUAJ4nBX4n8ApxcQe7J1zADoWhwbOnygCfba8x
tYK8cx0+GN29ZSmYGXsXgUw=
=jaCU
-----END PGP SIGNATURE-----

--==_Exmh_180667911P--
