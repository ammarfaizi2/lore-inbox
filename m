Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283501AbRLOTS7>; Sat, 15 Dec 2001 14:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283566AbRLOTSu>; Sat, 15 Dec 2001 14:18:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S283501AbRLOTSi>;
	Sat, 15 Dec 2001 14:18:38 -0500
Message-ID: <3C1BA20B.48FF8735@mandrakesoft.com>
Date: Sat, 15 Dec 2001 14:18:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andre Hedrick <andre@linux-ide.org>
Subject: Dropped patches
In-Reply-To: <Pine.LNX.4.10.10112151049260.13398-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Well blame that on the folks that are not taking kernel code that will
> allow you to solve this problem.  Linus is the number one offender.

Linus is taking some patches and not others right now...  so what?  A
couple of my patches, isolated and clearly unrelated to bio and mochel's
driver work, made it in.  Others got dropped.

I see several people (not just you Andre) whining about the dropped
patches, when it seems to clear to me that only a few things in specific
areas are getting applied right now.  For you specifically, Andre, Jen's
patches have been slated for 2.5.x for a while, so it seems blindingly
obvious that he would not take your IDE patches at least until the bio
subsystem is finished and clean, since you IDE patches would clearly
depend on the bio changes.

I do not believe this as a personal condemnation of your patches, or
bcrl's, or anyone else's.

Patience is a virtue ;-)   We have a long devel series in front of us
and we are only at the pre-patches to the FIRST 2.5.x release.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
