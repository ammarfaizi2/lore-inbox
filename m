Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265420AbSJRUER>; Fri, 18 Oct 2002 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265422AbSJRUER>; Fri, 18 Oct 2002 16:04:17 -0400
Received: from [195.39.17.254] ([195.39.17.254]:10244 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265420AbSJRUEQ>;
	Fri, 18 Oct 2002 16:04:16 -0400
Date: Fri, 18 Oct 2002 21:01:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
Message-ID: <20021018190101.GE237@elf.ucw.cz>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am eager to be able to sandbox my processes on a system without the
> help of suid-root programs (as I prefer to have none of these on my
> system).

You can do that using ptrace. subterfugue.sf.net.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
