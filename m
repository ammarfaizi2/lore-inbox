Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWIDPaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWIDPaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWIDPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:30:24 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50900 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964874AbWIDPaX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:30:23 -0400
Message-Id: <200609041529.k84FTolf004383@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
In-Reply-To: Your message of "Mon, 04 Sep 2006 11:06:50 +0400."
             <44FBD08A.1080600@tls.msk.ru>
From: Valdis.Kletnieks@vt.edu
References: <44FB5AAD.7020307@perkel.com>
            <44FBD08A.1080600@tls.msk.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1157383789_3784P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 11:29:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1157383789_3784P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Sep 2006 11:06:50 +0400, Michael Tokarev said:

> for faster operations.  But hell, first, try to avoid swappnig in the
> first place, by installing appropriate amount memory which is cheap
> nowadays,

Memory is indeed cheap.  However, if you're already at the max supported
memory configuration for your system, buying another RAM socket to plug that
cheap memory card into can be *really* expensive.

--==_Exmh_1157383789_3784P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE/EZtcC3lWbTT17ARAs8zAJ47RW9dKaFz6N31oV8Yzyz1uJkRHACfc6vs
ck6MA5aKcaqIDGMlP0PwQQ8=
=1zWt
-----END PGP SIGNATURE-----

--==_Exmh_1157383789_3784P--
