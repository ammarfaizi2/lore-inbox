Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWEGKfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWEGKfL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 06:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWEGKfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 06:35:11 -0400
Received: from keetweej.vanheusden.com ([213.84.46.114]:19683 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932118AbWEGKfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 06:35:10 -0400
Date: Sun, 7 May 2006 12:35:08 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "David S. Miller" <davem@davemloft.net>, mpm@selenic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060507103507.GV25646@vanheusden.com>
References: <2.420169009@selenic.com> <8.420169009@selenic.com>
	<20060505.141040.53473194.davem@davemloft.net>
	<20060506140850.GN25646@vanheusden.com>
	<1146928743.15364.89.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146928743.15364.89.camel@mindpipe>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Sat Apr 29 15:52:22 CEST 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Consider adding a cheap soundcard to the system and run
> > 'audio-entropyd': www.vanheusden.com/aed 
> Can't get much cheaper than the crap that comes on every motherboard
> these days ;-)
> Also aren't temp sensors (on the disk or mobo) a good entropy source?

Not sure about that. If I look at
http://keetweej.vanheusden.com/draw_temp.php?limit=86400 it looks like
that at least the cpu sensor gets only updated every x seconds.


Folkert van Heusden

-- 
Feeling generous? -> http://www.vanheusden.com/wishlist.php
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
