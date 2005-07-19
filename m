Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVGSSGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVGSSGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVGSSGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:06:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57816 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261992AbVGSSGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:06:36 -0400
Date: Tue, 19 Jul 2005 20:06:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Sharp Zaurus sl-5500 broken in 2.6.12
Message-ID: <20050719180624.GB15186@atrey.karlin.mff.cuni.cz>
References: <20050711193454.GA2210@elf.ucw.cz> <33703.127.0.0.1.1121130438.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33703.127.0.0.1.1121130438.squirrel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...and that's well known; but now I did some back tracking, and
2.6.12-rc1 works, 2.6.12-rc2 does *not* and 2.6.12-rc2 with arm
changes reverted works. I'll play a bit more.
							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
