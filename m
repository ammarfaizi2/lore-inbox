Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274700AbRIYXKi>; Tue, 25 Sep 2001 19:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274697AbRIYXKb>; Tue, 25 Sep 2001 19:10:31 -0400
Received: from urtica.linuxnews.pl ([217.67.192.54]:3338 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S274695AbRIYXKO>; Tue, 25 Sep 2001 19:10:14 -0400
Date: Wed, 26 Sep 2001 01:10:40 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 BUG()
In-Reply-To: <20010926004536.N8350@athlon.random>
Message-ID: <Pine.LNX.4.33.0109260104000.13603-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Andrea Arcangeli wrote:

Hi Andrea,

> do I guess right that you aren't running just ext2 on your machine? if
> so what other fses or patches are you running?

It was vanilla 2.4.10. No other patches. Just ext2. Reiserfs is compiled
in modules but it is not used (no modules loaded) 3 partitions.
The machine runs Celeron 366 (so no Athlon optimisations), one IDE drive
and 3c59x eth card. Rivafb compiled in.

Today I have applied ext3 patch and it runs with no problems till now.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku
http://tfuj.pl/cv.html :: http://tfuj.pl/pgp.asc

