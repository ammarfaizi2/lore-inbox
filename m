Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267075AbRGJSig>; Tue, 10 Jul 2001 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267074AbRGJSi1>; Tue, 10 Jul 2001 14:38:27 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:49624 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267073AbRGJSiR>; Tue, 10 Jul 2001 14:38:17 -0400
Date: Tue, 10 Jul 2001 14:38:18 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107101838.f6AIcI606442@devserv.devel.redhat.com>
To: fabrizio.gennari@philips.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.6 does not compile on Sparc
In-Reply-To: <mailman.994784040.20448.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.994784040.20448.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have a problem with kernel 2.4.6 on a Sparc. [...]

Next time, please be so kind to fold your lines properly.

Now, if you a true hacker, you might want to give a whirl to this:
 http://people.redhat.com/zaitcev/linux/linux-2.4.6-mallorn.diff

It certainly compiles, but does not work too well.
It may be a good start if you want to fix sparc(32).
Otherwise, forget it and use something else.

-- Pete
