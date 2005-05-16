Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVEPUKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVEPUKI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVEPUHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:07:44 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37130 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261849AbVEPUG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:06:27 -0400
Message-Id: <200505162005.j4GK5nR7016070@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andi Kleen <ak@muc.de>, Andy Isaacson <adi@hexapodia.org>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability 
In-Reply-To: Your message of "Mon, 16 May 2005 13:14:23 MDT."
             <m1ekc7vv8w.fsf@ebiederm.dsl.xmission.com> 
From: Valdis.Kletnieks@vt.edu
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org> <20050515094352.GB68736@muc.de> <m1oebbwsrf.fsf@ebiederm.dsl.xmission.com> <20050516110359.GA70871@muc.de>
            <m1ekc7vv8w.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116273945_5623P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 May 2005 16:05:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116273945_5623P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 May 2005 13:14:23 MDT, Eric W. Biederman said:

> Interesting.  I think that is a problem for the hypervisor maintainer.
> Although that is about enough to convince me to request a
> OS flag that says "please give me privacy" and later that can be passed
> down to the hypervisor.  My gut feel is running under a hypervisor
> is when things will at their most vulnerable.

Not really, because....

> I think discovering a crypto process will simply be a matter
> finding a https sever.  As for getting the timing how about
> initiating a https connection?  Getting rid of the noise will certainly
> be a challenge but you will have multiple attempts.

And the hypervisor is, if anything, adding noise.

--==_Exmh_1116273945_5623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiP0ZcC3lWbTT17ARAgMeAKDFLjlZzEvNSoPvBiSssMOk7ILTEwCfVlIo
AXqcvCE7+G8lqhUFMHvEqDY=
=+9nm
-----END PGP SIGNATURE-----

--==_Exmh_1116273945_5623P--
