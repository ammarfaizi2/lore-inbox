Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVAJQIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVAJQIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVAJQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:08:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:31390 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262309AbVAJQIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:08:05 -0500
Message-ID: <41E29C37.8030203@osdl.org>
Date: Mon, 10 Jan 2005 07:16:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mariusz Mazur <mmazur@kernel.pl>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
References: <200501081613.27460.mmazur@kernel.pl>
In-Reply-To: <200501081613.27460.mmazur@kernel.pl>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur wrote:
> Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> Changes:
> - updated to 2.6.10
> - switched to using svn and now ChangeLog is back :)
> - some minor changes here and there (made some headers ansi C compatible)
> 
> 
> Two weeks after 2.6.10, but you can blame Linus for releasing 2.6.10 just 
> before Christmas.
 >
> Like I've said two months ago - my scripts for testing new versions now do 
> separate asm-i386-ansi and asm-i386-noansi checks, so any ansi degradation in 
> linux or asm-i386 (like the one from 2.6.9) won't go unnoticed.
> 
> One more thing - llh is now officially one year old (first commits are from 
> December 2003). That's a long time for any hack to live. Especially a hack 
> this big and one that even has a couple of vendor specific variants. A couple 
> of discussions took place concerning this matter (in the last one Linus even 
> said, that he'll be accepting patches) and still I see no movement. I'd 
> really like to see glibc guys figuring out a way not to duplicate definitions 
> and structures from linux and starting to submit patches. That'd be a really 
> good (and much needed - glibc's and linux' headers conflict in lots of ugly 
> ways) first step.
> Anybody?

Yes, please don't give up.  I'll try to help soon (not that I'm
a glibc guy).

> Happy New Year.

Ditto.

---
~Randy
