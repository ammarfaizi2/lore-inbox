Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbTEKK5V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTEKK5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:57:21 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:7823 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261233AbTEKK5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:57:20 -0400
Date: Sat, 10 May 2003 18:56:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.69] suspend storing signed jiffies
Message-ID: <20030510165639.GA238@elf.ucw.cz>
References: <20030509160505.31cae893.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509160505.31cae893.shemminger@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Gets rid of warning because of using jiffies in int.

I submitted it through the trivial patch monkey. If linus does not
apply it, it is easiest just let Russell push it...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
