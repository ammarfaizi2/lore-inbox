Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbTHSTVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTHSTTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:19:46 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:58525 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261274AbTHSTSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:18:45 -0400
Date: Tue, 19 Aug 2003 21:18:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brandon Stewart <rbrandonstewart@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCO's "proof"
Message-ID: <20030819191843.GA11264@ucw.cz>
References: <3F422809.7080806@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F422809.7080806@yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 09:37:13AM -0400, Brandon Stewart wrote:
> compliments of "d1rkinator" from yahoo finance message board:
> 
> The code SCO finds offending:
> 
> www.heise.de/newsticker/data/jk-19.08.03-000/imh0.jpg
> www.heise.de/newsticker/data/jk-19.08.03-000/imh1.jpg
> 
> Its location in Linux:
> 
> /usr/src/linux-2.4.20/arch/ia64/sn/io/ate_utils.c
> 
> And its heritage:
> 
> minnie.tuhs.org/UnixTree/V7/usr/sys/sys/malloc.c.html
> 
> Ok, SCO: This was easy. Now, show us the other many examples.

Nothing new. See this LKML post by Neil Moore and the following thread,
named "Unix code in Linux" from Jun 19:

http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/1064.html

That code isn't present in 2.5 anymore.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
