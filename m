Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271231AbTGWTLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271233AbTGWTIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:08:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1810 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271226AbTGWTHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:07:36 -0400
Date: Wed, 23 Jul 2003 13:43:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: jimis@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
Message-ID: <20030723114322.GD729@zaurus.ucw.cz>
References: <3F1E6A25.5030308@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1E6A25.5030308@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With the current scheduler we can prioritize the CPU usage for each 
> process. What I think would be extremely useful (as I have needed it 
> many times) is the scheduling of disk I/O and net I/O traffic. 2 
> examples showing the importance (the numbers are estimations just to 
> explain whati I mean):

Yes that would be nice, and in 2.5 timeframe
there was patch doing that. Port it to 2.6 an test it!
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

