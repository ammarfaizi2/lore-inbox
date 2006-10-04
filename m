Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWJDVlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWJDVlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWJDVlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:41:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29165 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751162AbWJDVlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:41:10 -0400
Date: Wed, 4 Oct 2006 23:41:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Java Zombies
Message-ID: <20061004214103.GB8667@elf.ucw.cz>
References: <20061004120432.GA5170@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004120432.GA5170@gimli>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Nice subject ;-).

> Another strange behaviour...
> 
> I just got back into my java code and experienced really strange things:
> 
> I run a java app for a while, stop it, start it, do things with it
> (development tasks...) and suddenly java becomes defunct.
> 
> all running java processes are zombies and no trick will kill them. java gui
> stays onscreen but doesen't refresh.
> 
> and, even more strange: while CPUs stay at about 2 to 8% activity load
> increases. it's at 7 now after around 2 minutes
> 
>  
> I attach some info about my system (X60s 1702-55G)
> 
> oops: cat /proc/cpuinfo hangs!!
> 
> ...after that I could not even shutdown cleanly.
> I had to use SysRq keys to halt the system

Well, does it also happen when you reboot the machine?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
