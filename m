Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbUK3Wce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbUK3Wce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUK3Wce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:32:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:12928 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262359AbUK3WaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:30:19 -0500
Date: Tue, 30 Nov 2004 23:20:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stefan Seyfried <seife@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041130222027.GE1361@elf.ucw.cz>
References: <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <41AAED32.2010703@suse.de> <1101766833.4343.425.camel@desktop.cunninghams> <41AC6480.6020002@suse.de> <1101849416.5715.13.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101849416.5715.13.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>Putting only the absolutely necessary things into the kernel (the same
> > >>is true for the interactive resume thing - if someone wants interactive
> > >>startup at a failing resume, he has to use an initrd, i don't see a
> > >>problem with that) will probably increase the acceptance a bit :-)
> > > 
> > > That's fine if your initrd is properly configured and you're willing to
> > 
> > This is something distributions have to take care of.
> 
> No; it's something the users will have to take care of. Distro makers
> might make the process more automated, but in the end it's the user's
> problem if it doesn't work.

Actually, no, its not like that. 

User will click icon in KDE, and if it does not suspend & resume
properly, distribution has problem to fix. And yes, it works well in
SUSE9.2.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
