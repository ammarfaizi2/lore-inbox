Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTDMWoj (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTDMWoi (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:44:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43538 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262649AbTDMWoi (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 18:44:38 -0400
Date: Mon, 14 Apr 2003 00:56:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: irda-users@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: toshiba FIR in 2.5.X
Message-ID: <20030413225625.GA12046@atrey.karlin.mff.cuni.cz>
References: <20030413223527.GA8054@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413223527.GA8054@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I was able to get toshiba-FIR working in 2.5.X with rather nasty hacks
> --  like setting max speed to 9600 and disabling self tests. Now it
> kind-of works..... slowly.
> 
> [It failed self-test. So I disabled it. Then it tried to communicate
> with t68i phone at 1Mbit  . Ouch. I tried to limit it at 115k but that
> did not do the trick, so I limited it to 9600. That helped.]

Tried to ko to 57k, it does not work.
							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
