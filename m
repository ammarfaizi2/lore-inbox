Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVKGMp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVKGMp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKGMp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:45:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42412 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932478AbVKGMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:45:56 -0500
Date: Thu, 6 Oct 2005 07:16:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: spitz autorepeat
Message-ID: <20051006071647.GA2079@spitz.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz> <1130773530.8353.39.camel@localhost.localdomain> <20051102125107.GA12891@elf.ucw.cz> <1130939279.8523.10.camel@localhost.localdomain> <20051102135253.GK30194@elf.ucw.cz> <1130942647.8523.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130942647.8523.19.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Spitz is *very* touchy - autorepeat is way too fast for such small and
crappy keyboard. Could we get some saner defaults? Not faster than
250msec delay, 30 per second....
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

