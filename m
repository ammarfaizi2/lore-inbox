Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUAOQSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUAOQSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:18:21 -0500
Received: from [128.173.54.129] ([128.173.54.129]:27520 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265152AbUAOQSM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:18:12 -0500
Message-Id: <200401151617.i0FGHW1a005870@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Tim Cambrant <tim@cambrant.com>
Cc: Erik Hensema <erik@hensema.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: True story: "gconfig" removed root folder... 
In-Reply-To: Your message of "Thu, 15 Jan 2004 17:07:59 +0100."
             <20040115160759.GA5458@cambrant.com> 
From: Valdis.Kletnieks@vt.edu
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <87ptdl2q7l.fsf@asmodeus.mcnaught.org> <slrnc0dct5.2o5.erik@bender.home.hensema.net>
            <20040115160759.GA5458@cambrant.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1689242675P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Jan 2004 11:17:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1689242675P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Jan 2004 17:07:59 +0100, Tim Cambrant said:
> On Thu, Jan 15, 2004 at 03:37:09PM +0000, Erik Hensema wrote:
> > Yes, having your user homedirectory removed is *much* better :-)
> 
> How about using /usr/src and giving permissions to that directory
> to your non-root user?

So /usr/src gets removed instead.

That's not fixing the problem, it's moving it around the filesystems.


--==_Exmh_-1689242675P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFABr0bcC3lWbTT17ARAnP8AJ48aMuQVkJhH/9RPeE5iETnG9JL+ACgwCcq
nTOBcHHnZFv35xLf6Mh/vJo=
=jR4i
-----END PGP SIGNATURE-----

--==_Exmh_-1689242675P--
