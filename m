Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTLUSWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTLUSWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 13:22:39 -0500
Received: from mother.ds.pg.gda.pl ([153.19.213.213]:53327 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S262050AbTLUSWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 13:22:38 -0500
Date: Sun, 21 Dec 2003 19:22:39 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
Message-ID: <20031221182239.GA12760@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	linux-kernel@vger.kernel.org
References: <200312190314.13138.schwientek@web.de> <3FE2B717.7020502@convergence.de> <20031219213734.GA27975@irc.pl> <3FE3FC11.70009@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE3FC11.70009@wmich.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 02:36:49AM -0500, Ed Sweetman wrote:
> But, what's really the point in using X with matroxfb? You lose half 
> your memory off the bat that X cannot access and you get no added 
> performance or anything.  It really does not seem worth it.  Use 

 32 MiB of videoram is more than enough.
And the point is: comfortable work in console (bigger resolution ->
more information on screen), sometimes even with small fbtv window
in corner. And ability to run browsers like mozilla in X, when
it's needed. And ability to watch movies with mplayer in both.

 I don't understand why matroxfb has regressed in 2.6 compared to 2.4.

-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated. -- Alex Yuriev
|> Playing: Electric Rudeboyz - Beton ...
