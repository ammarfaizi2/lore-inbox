Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSDGW0q>; Sun, 7 Apr 2002 18:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313428AbSDGW0p>; Sun, 7 Apr 2002 18:26:45 -0400
Received: from [195.39.17.254] ([195.39.17.254]:14730 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313421AbSDGW0o>;
	Sun, 7 Apr 2002 18:26:44 -0400
Date: Sun, 7 Apr 2002 16:21:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: brian@worldcontrol.com, linux-kernel@vger.kernel.org
Subject: Re: more on 2.4.19pre... & swsusp
Message-ID: <20020407162150.E46@toy.ucw.cz>
In-Reply-To: <20020406200918.GA1535@top.worldcontrol.com> <1018127923.4270.60.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsusp works for me in wolk3.2 but it doesn't use rmap. Seems like the
> swsusp patch was just hacked into ac so it would compile with little to
> no changes from wolk3.2.   

What does it mean "doesn't use rmap"?

Oh, and it was not merged from wolk. Swsusp in both -wolk and -ac is hacked
from the same tree on my machine. I'm working on makng it work in -ac.

									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

