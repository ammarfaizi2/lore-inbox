Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTDMWXk (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTDMWXk (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:23:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44816 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262600AbTDMWXk (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 18:23:40 -0400
Date: Mon, 14 Apr 2003 00:35:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: irda-users@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: toshiba FIR in 2.5.X
Message-ID: <20030413223527.GA8054@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was able to get toshiba-FIR working in 2.5.X with rather nasty hacks
--  like setting max speed to 9600 and disabling self tests. Now it
kind-of works..... slowly.

[It failed self-test. So I disabled it. Then it tried to communicate
with t68i phone at 1Mbit  . Ouch. I tried to limit it at 115k but that
did not do the trick, so I limited it to 9600. That helped.]


							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
