Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUIXQCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUIXQCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUIXQCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:02:35 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:41601 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S268878AbUIXQCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:02:22 -0400
Date: Fri, 24 Sep 2004 18:02:22 +0200
From: Martin Mares <mj@ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       mingo@elte.hu, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040924160222.GA2292@ucw.cz>
References: <1095045628.1173.637.camel@cube> <20040913074230.GW2660@holomorphy.com> <1095084688.1173.1329.camel@cube> <20040913142752.GC9106@holomorphy.com> <20040923131312.GQ467@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923131312.GQ467@openzaurus.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Actually 64-bit pids would be very nice for clustering.
> mj did that once, IIRC, maybe he still has a patch?

No, it was 32-bit pids in the 16-bit pid times :)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
IBM = Inside Black Magic
