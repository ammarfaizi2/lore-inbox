Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSI3TO1>; Mon, 30 Sep 2002 15:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261303AbSI3TO1>; Mon, 30 Sep 2002 15:14:27 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:8324 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261293AbSI3TOX>;
	Mon, 30 Sep 2002 15:14:23 -0400
Date: Mon, 30 Sep 2002 14:19:38 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard/mouse driver in 2.5 broken was Re: v2.6 vs v3.0
In-Reply-To: <p73zntzqwxz.fsf_-_@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0209301417530.3692-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2002, Andi Kleen wrote:

> I have a similar problem. The 2.5 keyboard/psmouse driver does not work
> at all with my KVM. It's a bit unusual combination in that I run an 
> Intellimouse on it and the KVM doesn't let all Intellimouse extensions
> through, but it is still autodetected as that. Normally (xfree86, 2.4 gpm,
> other OS) it works fine when just setting PS/2 mouse maually. Even when I 
> hack the kernel to force PS/2 instead of the IMPS/2 then I just get 
> endless "psmouse: lost synchronization .." messages.

I have some other reports on my status page showing problems with the KVM 
and mice/keyboards.  What is the last kernel version you've seen this with?


