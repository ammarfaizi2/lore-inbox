Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVCCFEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVCCFEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCCFEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:04:20 -0500
Received: from h80ad24bc.async.vt.edu ([128.173.36.188]:56072 "EHLO
	h80ad24bc.async.vt.edu") by vger.kernel.org with ESMTP
	id S261429AbVCCFBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:01:31 -0500
Message-Id: <200503030501.j2351DOZ014786@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering 
In-Reply-To: Your message of "Wed, 02 Mar 2005 21:32:23 EST."
             <42267737.4070702@pobox.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
            <42267737.4070702@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109826070_4346P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Mar 2005 00:01:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109826070_4346P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Mar 2005 21:32:23 EST, Jeff Garzik said:
> I also note that part of the problem that motivates the even/odd thing 
> is a tacit acknowledgement that people only _really_ test the official 
> releases.
> 
> Which IMHO backs up my opinion that we simply need more frequent releases.

Or more testers of things other than <whatever we call stable this week>
(which is where I see the *real* problem as being).

It doesn't matter *what* we call the "testing" releases.  They aren't getting
tested enough.  I've posted a fair number of "the latest -mm broke FOO" notes -
but assuming that "the first guy to hit it" is randomly distributed across all
the -mm users, there really can't be a whole lot of others doing it, as my
number seems to come up waaay too often if there's a large pool of testers...

Either that, or I really *am* the most bleeding-edge loon in my time zone.

--==_Exmh_1109826070_4346P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCJpoWcC3lWbTT17ARAjcDAKDKjEhlwXr65q2cGTUjPTEjuAPl2ACcC8an
yiglqvAMOOXa9M6hX0UnM+g=
=laUF
-----END PGP SIGNATURE-----

--==_Exmh_1109826070_4346P--
