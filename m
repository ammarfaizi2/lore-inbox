Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSGCQaf>; Wed, 3 Jul 2002 12:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSGCQae>; Wed, 3 Jul 2002 12:30:34 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:25568 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S317068AbSGCQad>; Wed, 3 Jul 2002 12:30:33 -0400
Date: Wed, 3 Jul 2002 12:38:00 -0400
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703163800.GA5689@lnuxlab.ath.cx>
References: <20020703094031.GA4462@lnuxlab.ath.cx> <200207031057.MAA03204@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207031057.MAA03204@cave.bitwizard.nl>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 12:57:45PM +0200, Rogier Wolff wrote:
> That said, maybe there is a whole lot of (random) reads going on 
> on that disk? Are you swapping at the same time? Or maybe your
> dayly "updatedb" is running?

Nope, I've even been running without swap.. And nope, no updatedb
running at the time either..

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
