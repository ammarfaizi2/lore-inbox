Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUCKGYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbUCKGYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:24:15 -0500
Received: from [212.239.225.213] ([212.239.225.213]:41600 "EHLO precious")
	by vger.kernel.org with ESMTP id S262794AbUCKGYO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:24:14 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
Date: Thu, 11 Mar 2004 07:23:41 +0100
User-Agent: KMail/1.6.1
Cc: James Ketrenos <jketreno@linux.co.intel.com>
References: <404E27E6.40200@linux.co.intel.com> <200403100852.35429.lkml@kcore.org>
In-Reply-To: <200403100852.35429.lkml@kcore.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403110723.47400.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 10 March 2004 08:52, Jan De Luyck wrote:
> I can't test the actual transmitting since I've got no accesspoint handy.
> Will do so when at home, though.

Tested this. It works, _if_ you set the AP address first, otherwise it bails 
out with 'Fatal interrupt'.

Jan

- -- 
YOU!!  Give me the CUTEST, PINKEST, most charming little VICTORIAN
DOLLHOUSE you can find!!  An make it SNAPPY!!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUAXxUQQOfidJUwQRAjzJAJ9IpEthgDjGO5pGFnzWRMU5+WmgpgCfQ2xt
oCVVPgM/duRgPUWUkWAN1kA=
=BbJ0
-----END PGP SIGNATURE-----
