Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266253AbUGJOJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUGJOJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 10:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUGJOJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 10:09:15 -0400
Received: from ktown.kde.org ([131.246.103.200]:954 "HELO ktown.kde.org")
	by vger.kernel.org with SMTP id S266253AbUGJOJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 10:09:14 -0400
Date: Sat, 10 Jul 2004 16:09:12 +0200
From: Oswald Buddenhagen <ossi@kde.org>
To: linux-kernel@vger.kernel.org
Subject: Re: (att. ismail) [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710140912.GB13925@ugly.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200407101503.58124.roger.larsson@norran.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407101503.58124.roger.larsson@norran.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 03:03:58PM +0200, Roger Larsson wrote:
> But it does sound as a io scheduler problem - but 2-3 seconds!?
> 
nothing particularly unusual on my system ... when an updatedb or a 'cvs
up' or 'make install' of kde are running i often get hangs of up to 10
seconds (not the sound, though, as xmms with oss output seems less
susceptible to this, but "random" other processes freeze hard for that
time). and with 2.4 ... errm ... 30 seconds are usual, and 60 seconds
are still not exceptional.
for the record: i have 1GB of ram, no swap, and reasonably fast disks
(and yes, udma is enabled ;).

greetings

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
