Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbSI3Uck>; Mon, 30 Sep 2002 16:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSI3Uck>; Mon, 30 Sep 2002 16:32:40 -0400
Received: from ns.suse.de ([213.95.15.193]:65298 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261348AbSI3Ucj>;
	Mon, 30 Sep 2002 16:32:39 -0400
Date: Mon, 30 Sep 2002 22:38:04 +0200
From: Andi Kleen <ak@suse.de>
To: Thomas Molina <tmolina@cox.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: keyboard/mouse driver in 2.5 broken was Re: v2.6 vs v3.0
Message-ID: <20020930223804.A29396@wotan.suse.de>
References: <p73zntzqwxz.fsf_-_@oldwotan.suse.de> <Pine.LNX.4.44.0209301417530.3692-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209301417530.3692-100000@dad.molina>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 02:19:38PM -0500, Thomas Molina wrote:
> On 30 Sep 2002, Andi Kleen wrote:
> 
> > I have a similar problem. The 2.5 keyboard/psmouse driver does not work
> > at all with my KVM. It's a bit unusual combination in that I run an 
> > Intellimouse on it and the KVM doesn't let all Intellimouse extensions
> > through, but it is still autodetected as that. Normally (xfree86, 2.4 gpm,
> > other OS) it works fine when just setting PS/2 mouse maually. Even when I 
> > hack the kernel to force PS/2 instead of the IMPS/2 then I just get 
> > endless "psmouse: lost synchronization .." messages.
> 
> I have some other reports on my status page showing problems with the KVM 
> and mice/keyboards.  What is the last kernel version you've seen this with?

2.5.39

-Andi
