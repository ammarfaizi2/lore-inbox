Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265425AbSJRUFS>; Fri, 18 Oct 2002 16:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265439AbSJRUFS>; Fri, 18 Oct 2002 16:05:18 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9732 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265425AbSJRUEr>;
	Fri, 18 Oct 2002 16:04:47 -0400
Date: Fri, 18 Oct 2002 20:26:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: Use of yield() in the kernel
Message-ID: <20021018182558.GD237@elf.ucw.cz>
References: <200210151536.39029.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210151536.39029.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is the list of files using yield(), excluding non-i386 arch specific files:
> 
...
> kernel/suspend.c

This is okay.
									Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
