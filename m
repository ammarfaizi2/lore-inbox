Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTFYPze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFYPzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:55:33 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:37591 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264608AbTFYPz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:55:26 -0400
Date: Wed, 25 Jun 2003 12:09:22 -0400
From: Jeff <jeffpc@optonline.net>
Subject: Re: 2.5.73 -- Uninitialised timer! (i386)
In-reply-to: <16121.27054.257166.231690@gargle.gargle.HOWL>
To: Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@digeo.com>
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org
Message-id: <200306251209.31070.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <20030624124800.72bfb98d.akpm@digeo.com>
 <20030624153154.7243549d.akpm@digeo.com>
 <16121.27054.257166.231690@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hmmm, it appears that the patch didn't make it into -bk2. (or did I mix up the 
times?) I also get the spinlock warning...

gcc version 2.95.4

Jeff.

- -- 
Keyboard not found!
Press F1 to enter Setup
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++ck2wFP0+seVj/4RAudmAKDez0rPcXSTIj2YIP77mjEP4wgrgACgtqTv
0IqyMwdcMVBY/HkoPS29vbk=
=Syb0
-----END PGP SIGNATURE-----

