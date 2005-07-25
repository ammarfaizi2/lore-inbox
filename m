Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVGYVjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVGYVjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGYVjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:39:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16261 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261509AbVGYVjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:39:41 -0400
Date: Mon, 25 Jul 2005 23:39:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725213929.GC8684@elf.ucw.cz>
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <d120d500050725081664cd73fe@mail.gmail.com> <20050725165014.B7629@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725165014.B7629@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can we change this to "while (!kthread_should_stop())" to make me
> > completely happy?
> 
> I still ask, and I'll keep repeating this.  What is the difference
> between this and the reference implementation which is known to
> work on other hardware.

I think I posted diffs already, but they were rather big and against
wrong version. I'll try to get better diffs.

> Let's not go all out on one implementation for one set of hardware,
> but try to work out what we need to do to the generic reference
> implementation to make it work on this hardware.

I did not know it is supposed to work on other devices, too. My
fault.
							Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
