Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282187AbRL0PKA>; Thu, 27 Dec 2001 10:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283777AbRL0PJu>; Thu, 27 Dec 2001 10:09:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62989 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S282187AbRL0PJp>; Thu, 27 Dec 2001 10:09:45 -0500
Date: Thu, 27 Dec 2001 16:09:42 +0100
From: Martin Mares <mj@ucw.cz>
To: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011227160942.A7960@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011223174608.A25335@thyrsus.com> <20011227091702.A8528@zapff.research.canon.com.au> <20011226233413.GA17037@msp-150.man.olsztyn.pl> <E16JTce-0000cp-00@starship.berlin> <20011227112431.GA1582@msp-150.man.olsztyn.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227112431.GA1582@msp-150.man.olsztyn.pl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> If you look at my post more closely, you'll see I used `kB' (that's small
> k and capital B) for decimal kilobyte. I would never suggest using `KB'
> (that's capital K and capital B) for it. I do agree that `KB' is traditionally
> used for binary kilobytes, but what about MB, GB and so on? These _are_
> ambiguous. I am in favour of using Ki, Mi and Gi for binary quantities.

Yes, the current MB/GB units are awfully ambiguous, but using Mi/Gi won't
cure the confusion as nobody will know whether MB/GB in that text means
the old-fashioned name of binary megabyte or the decimal megabyte according
to the new standard. Yes, the confusion might die out after a long period
of time of everybody switches to the new system, but I seriously doubt
it will happen in the near future.

It seems that the only way which is going to work is to create a new decimal
prefix for units of information as well. Not a particularly nice solution,
but probable the only working one.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Every program in development at MIT expands until it can read mail.
