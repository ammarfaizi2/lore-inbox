Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSGaMoM>; Wed, 31 Jul 2002 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318135AbSGaMoM>; Wed, 31 Jul 2002 08:44:12 -0400
Received: from revdns.flarg.info ([213.152.47.18]:23447 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S318123AbSGaMoL>;
	Wed, 31 Jul 2002 08:44:11 -0400
Date: Wed, 31 Jul 2002 13:51:08 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: why no new 2.5-dj patch ?
Message-ID: <20020731125108.GA14639@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm fed up of answering the same questions over and over,
so I figured I'd post this here.

Most common question I'm getting right now seems to be summed up
as "Why haven't I done a 2.5-dj since .27 ?" (Yup, a whole 2 point
releases, and people are breaking into a sweat)

* Due to the huge driver breakage during .28/.29/.30tobe,
  Compilation issues aside, I've not had much luck in even
  getting the last few kernels to boot on most of my test boxes.
  If I don't get a 2.5-dj booting on all my test boxes, I won't
  make it available.

* Lack of time.
  I've been busy with x86-64, and other projects.

* Vacation.
  As of Friday, I'm taking time out for a real holiday for the
  whole week for the first time in a year. Ie, no net connection.

The last point marks an important change in the way I've been
working up until now. I spent a while trying to figure out
how to take a holiday, and not have to come back to a nightmare
resync. FSF purists will hate me for it, but I've started playing
with BitKeeper again, and it's working out.
(The curious can look around at http://linux-dj.bkbits.net)

I've put off pushing bits to Linus this week to deliberatly
make life more difficult for myself syncing his latest tree
with mine, to see if bk really will work out. So far what usually
takes me the better part of an hour I can now do in 10 minutes.

So when I come back, resyncing should be a lot less painful than
it used to be, and I'll start looking at pushing some of the bits
that have been hanging around for a while towards Linus.

One final point: Due to me being away for a week, I won't be
merging anything new to my tree 8) Feel free to still send it,
and I'll pick it up when I return.


		Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
