Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUJAThV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUJAThV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUJATfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:35:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50333 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266308AbUJATem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:34:42 -0400
Message-Id: <200410011934.i91JYU2t014578@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: Possible GPL Violation of Linux in Amstrad's E3 Videophone 
In-Reply-To: Your message of "Fri, 01 Oct 2004 17:40:07 -0000."
             <100120041740.9915.415D967600014EC2000026BB2200758942970A059D0A0306@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <100120041740.9915.415D967600014EC2000026BB2200758942970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2086593552P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Oct 2004 15:34:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2086593552P
Content-Type: text/plain; charset=us-ascii

On Fri, 01 Oct 2004 17:40:07 -0000, jmerkey@comcast.net said:

> Oops.  Too late.  Linux has a huge trail of everyone's code under the GPL so you cannot
> re-release the code under another license unless the entire code base is re-written.  So 
> anyone can fork it at any point and claim, "we never accepted the license even though 
> we download and use the code.  Guess what, this is legally valid to say and totally 
> circumvents the GPL, they just have to leave your copyright notices in place.

Umm.. It's OK to take the GPL'ed source and make your own fork for your own
amusement.  Trying to distribute it without accepting the GPL on the parts
you're shipping copies of *is* a problem. As the COPYING file says:

  5. You are not required to accept this License, since you have not
signed it.  However, nothing else grants you permission to modify or
distribute the Program or its derivative works.  These actions are
prohibited by law if you do not accept this License.  Therefore, by
modifying or distributing the Program (or any work based on the
Program), you indicate your acceptance of this License to do so, and
all its terms and conditions for copying, distributing or modifying
the Program or works based on it.

So you have three choices: You can accept the terms of the GPL, and comply
with them, or you can not ship those pieces covered by the GPL (basically
the entire kernel), or you can ship it in violation and wait for the hate
mail to start arriving..... 
 


--==_Exmh_2086593552P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBXbFEcC3lWbTT17ARAhzzAKCc4LLbRTbWYRZSbmJ/bI1IxdAM6gCg6SNE
ASiOzl6UB5FAn9gyKHR0glE=
=ULOi
-----END PGP SIGNATURE-----

--==_Exmh_2086593552P--
