Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263611AbUEGOZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbUEGOZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUEGOZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:25:30 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:12416 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263596AbUEGOZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:25:12 -0400
Date: Thu, 6 May 2004 12:05:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andre Eisenbach <andre@ironcreek.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon Mobile XP CPU speed problem
Message-ID: <20040506100512.GA226@elf.ucw.cz>
References: <200404091723.55628.andre@ironcreek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404091723.55628.andre@ironcreek.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My notebook [1], powered by a AMD Athlon XP2400+ (k7) is slowing down when 
> running on battery. This happens regardless of whether or not cpu frequency 
> scaling is enabled or not. /proc/cpuinfo still shows maximum frequency, but 
> the computer is definitely slowed down considerably.

That may well be bios feature. Maybe battery is not even able to get
you enough juice for full speed....
									Pavel
-- 
When do you have heart between your knees?
