Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbTD0W2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTD0W2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 18:28:51 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:56715 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261886AbTD0W2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 18:28:50 -0400
Date: Wed, 23 Apr 2003 18:32:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [FBDEV BK] Updates and fixes.
Message-ID: <20030423163211.GB7131@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    [RIVA FBDEV] Cursor fixes. Almost done. At least it looks normal most of the time.

I still see cursor problems on 2.5.68
(vesafb): softcursor is not being hidden
properly (backspace in bash creates
solid line), and "small"/"big" cursor
setting seems to somehow propagate
around virtual consoles...

At least cursor no longer hides itself...

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

