Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSBIBmK>; Fri, 8 Feb 2002 20:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSBIBmA>; Fri, 8 Feb 2002 20:42:00 -0500
Received: from out019pub.verizon.net ([206.46.170.98]:1505 "EHLO
	out019.verizon.net") by vger.kernel.org with ESMTP
	id <S288040AbSBIBls>; Fri, 8 Feb 2002 20:41:48 -0500
Date: Fri, 8 Feb 2002 20:39:26 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: de_put: entry sys already free!
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020209011023.UBOE29231.out007.verizon.net@pool-141-150-235-204.delv.east.verizon.net> <Pine.GSO.4.21.0202082030080.28514-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0202082030080.28514-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Feb 08, 2002 at 08:30:51PM -0500
Message-Id: <20020209014147.QRFC379.out019.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alexander Viro wrote:
> 
> Fix already merged and no, it's not quite harmless.

Thanks for the patch...and how do I fix any damage it caused if it's not
harmless?  It sure didn't seem to cause any.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxkfcYACgkQBMKxVH7d2wqQEgCg6hj/nUXB92aylwKCpg41w7Wt
XAIAoLkykjmxn6a32cC9pMSYuHBNkCJA
=O2cd
-----END PGP SIGNATURE-----
