Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTGLWjl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270001AbTGLWjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:39:41 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:223 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268702AbTGLWjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:39:33 -0400
Date: Sun, 13 Jul 2003 00:52:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030712225258.GB1508@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz> <1058038701.2482.25.camel@laptop-linux> <20030712201525.GB446@elf.ucw.cz> <1058041325.2007.4.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058041325.2007.4.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, you don't understand.
> > 
> > Magic SysRq is well known mechanism for torturing running
> > kernel. Kernel hackers have it enabled, security-consious people have
> > it disabled, and it is /proc-tweakable. It also works in cases like
> > "the only keyboard on serial terminal", etc. 
> 
> Ah okay. So the security by obscurity bit was wrong, but the general
> idea of SysRq-Esc was right?

I guess so. Advantage is that people already know about Magic Sysrq
and know how to disable it. (It would be something like Sysrq-E, you
can't really use esc).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
