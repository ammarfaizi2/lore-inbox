Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267546AbUHEFMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267546AbUHEFMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267550AbUHEFMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:12:18 -0400
Received: from math.ut.ee ([193.40.5.125]:56266 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S267546AbUHEFMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:12:07 -0400
Date: Thu, 5 Aug 2004 08:11:59 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] problems with modular and nonmodular ide mix
In-Reply-To: <20040802001201.GA14589@logos.cnet>
Message-ID: <Pine.GSO.4.44.0408050811340.29964-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > OK, but should CONFIG_BLK_DEV_CMD640 then depend on CONFIG_BLK_DEV_IDE=y
> > and show a comment otherwise?
>
> Yep, that sounds good.
>
> But that was not what your patch was trying to do, was it?

No, I'll make a new patch when I'm back from a trip.

-- 
Meelis Roos (mroos@linux.ee)

