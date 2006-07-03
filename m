Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWGCVu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWGCVu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWGCVu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:50:29 -0400
Received: from pool-71-254-76-103.ronkva.east.verizon.net ([71.254.76.103]:59076
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751004AbWGCVu2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:50:28 -0400
Message-Id: <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext4 features
In-Reply-To: Your message of "Mon, 03 Jul 2006 17:34:18 EDT."
             <44A98D5A.5030508@tmr.com>
From: Valdis.Kletnieks@vt.edu
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
            <44A98D5A.5030508@tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151963422_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 17:50:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151963422_4949P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jul 2006 17:34:18 EDT, Bill Davidsen said:
> I think he is talking about another problem. RAID addresses detectable
> failures at the hardware level. I believe that he wants validation after
> the data is returned (without error) from the device. While in most
> cases if what you wrote and what you read don't match it's memory,
> improving the chances of catching the error is useful, given that
> non-server often lacks ECC on memory, or people buy cheaper non-parity
> memory.

There's other issues as well.  Why do people run 'tripwire' on boxes that
have RAID on them?

--==_Exmh_1151963422_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqZEecC3lWbTT17ARAg9WAJ9V8gw6TlmVOPgyT6cTMxxdRMe8ygCggwQb
xVOAxw2a03p3lCEambW5e5E=
=uQbH
-----END PGP SIGNATURE-----

--==_Exmh_1151963422_4949P--
