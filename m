Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUCKTaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCKTaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:30:55 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:33921 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261681AbUCKTaZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:30:25 -0500
Message-Id: <200403111930.i2BJU9oh004246@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LKM rootkits in 2.6.x 
In-Reply-To: Your message of "Thu, 11 Mar 2004 20:16:28 +0100."
             <1079032587.7517.1.camel@leto.cs.pocnet.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk> <20040311184835.GA21330@redhat.com>
            <1079032587.7517.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_767934831P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Mar 2004 14:30:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_767934831P
Content-Type: text/plain; charset=us-ascii

On Thu, 11 Mar 2004 20:16:28 +0100, Christophe Saout said:

> Ugh... this sounds ugly. This should be forbidden. I mean, what are
> things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
> whatever they want?

If the binary blob knows enough about the innards to be able to do binary
patching, it's a derived work and should be GPL.

Even the NVidia driver isn't *that* evil... :)

--==_Exmh_767934831P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAUL5BcC3lWbTT17ARAjyjAKCQ2x7JSJS1Jfz1sCXjpGOABoSlhwCgu2L4
d42hDXk+AY2rqfrjSxQNJng=
=Ie98
-----END PGP SIGNATURE-----

--==_Exmh_767934831P--
