Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264440AbTCXWAm>; Mon, 24 Mar 2003 17:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264443AbTCXWAm>; Mon, 24 Mar 2003 17:00:42 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264440AbTCXWAl>;
	Mon, 24 Mar 2003 17:00:41 -0500
Date: Mon, 24 Mar 2003 00:13:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.65: *huge* interactivity problems
Message-ID: <20030323231306.GA4704@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having awfull interactivity problems. While lingvistic application
(slm from nltools.sf.net) is running, machine is unusable. I still can
read text in most, but can't login, can't run links, can't... For
minutes.

slm does a lot of computation over ~250MB dataset, but during stall
disk was not active.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
