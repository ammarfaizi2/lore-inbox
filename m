Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUEQPN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUEQPN1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUEQPN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:13:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28369 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261602AbUEQPNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:13:25 -0400
Date: Mon, 17 May 2004 17:13:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Strange problems with hanging sync
Message-ID: <20040517151325.GA27155@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.6.5 kernel. I did some pretty long and very disk intensive
lingvistics job, then ^Z stopped it, and ran sync. sync was not
returning for few minutes, I ran second one but it hang too. I ran
second sync, but it appeared hanged too. I told lingvistics job to
quit early, and then both syncs finished. Anyone seen something
similar?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
