Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUJCUeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUJCUeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUJCUd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:33:59 -0400
Received: from gprs214-52.eurotel.cz ([160.218.214.52]:7296 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268134AbUJCUd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:33:58 -0400
Date: Sun, 3 Oct 2004 22:33:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Clouter <alex-kernel@digriz.org.uk>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.9-rc1->rc3 and futex's hang
Message-ID: <20041003203345.GB3379@elf.ucw.cz>
References: <20041003115649.GA22399@inskipp.digriz.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041003115649.GA22399@inskipp.digriz.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ----------------
> summary: kernel's 2.6.9-rc1->2.6.9-rc3 lock up my jabber client (on a futex)
> keywords: futex, 2.6.9, hanging (no oops)
> ----------------
> 
> I'm getting desperate, my Jabber client keeps locking up and its kernel
> 2.6.9-rc1 -> 2.6.9-rc3 [Linux version 2.6.9-rc3 (alex@inskipp) (gcc version
> 3.3.4 (Debian 1:3.3.4-13)) #12 Sat Oct 2 15:47:07 BST 2004; untainted] that
> are causing the problems (bizarrely), whilst with 2.6.8.1 everything is
> peachy.
> 
> I have tried trimming all the 'fancy' bits/options I choose in the kernel but 
> it seems to have no effect.
> 
> The jabber client (with an strace) shows it hangs on a futex.  I do not have
> a clue if this is related to your OpenOffice issue[1], for you it segfaults
> OO, for me it hangs my Jabber client (tkabber) and I have to kill
> it. :(

I just tried OOo again, and yes, it still crashes. Openoffice.org641.



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
