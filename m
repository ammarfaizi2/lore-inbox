Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281682AbRLAV0M>; Sat, 1 Dec 2001 16:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281692AbRLAV0C>; Sat, 1 Dec 2001 16:26:02 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:6331 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S281682AbRLAVZr>;
	Sat, 1 Dec 2001 16:25:47 -0500
Date: Sat, 1 Dec 2001 22:25:40 +0100
From: Francois Romieu <romieu@mail.cogenit.fr>
To: Raja R Harinath <harinath@cs.umn.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path changes
Message-ID: <20011201222540.A11220@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.33.0112011830550.14290-100000@netfinity.realnet.co.sz> <d9snau4qsl.fsf@han.cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <d9snau4qsl.fsf@han.cs.umn.edu>; from harinath@cs.umn.edu on Sat, Dec 01, 2001 at 02:40:58PM -0600
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc trimmed]

Raja R Harinath <harinath@cs.umn.edu> :
[...]
> Not a safe change.  If you really really really want to change it, it

It is (different logic, not really beautiful function but safe for sure).
It somebody really wants to change any code, reading it first wouldn't 
hurt imho.

-- 
Ueimor
