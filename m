Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWATQaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWATQaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWATQaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:30:05 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:23309 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751039AbWATQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:30:03 -0500
Message-ID: <43D10FF8.8090805@superbug.co.uk>
Date: Fri, 20 Jan 2006 16:29:44 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Loftis <mloftis@wgops.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
In-Reply-To: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis wrote:

> OK, I don't know abotu others, but I'm starting to get sick of this 
> unstable stable kernel.  Either change the statements allover that 
> were made that even-numbered kernels were going to be stable or open 
> 2.7. Removing devfs has profound effects on userland.  It's one thing 
> to screw with all of the embedded developers, nearly all kernel module 
> developers, etc, by changing internal APIs but this is completely out 
> of hand.
>
> Normally I wouldn't care, and I'd just stay away from 'stable' until 
> someone finally figured out that a dev tree really is needed, but I 
> can't stay quiet anymore.  2.6.x is anything but stable right now.  It 
> might be stable in the sense that most any development kernel is 
> stable in that it runs without crashing, but it's not at all stable in 
> the sense that everything is changing as if it were an odd numbered 
> dev tree.
>
> Yes, I'm venting some frustrations here, but I can't be the only one.  
> I know now I'm going to be called a troll or a naysayer but whatever.  
> The fact is it needs saying.  I shouldn't have to do major changes to 
> accomodate sysfs in a *STABLE* kernel when going between point revs.  
> This is just not how it's been done in the past.
>
> I can sympathize with the need to push code out to users faster, and 
> to simplify maintenance as LK is a huge project, but at the expense of 
> how many developers?


It is unclear what you are really ranting about here. The "stable" 
kernel is stable or at least as stable as it is going to be. It is left 
to distros to make it even more stable. The interface to user land has 
not changed.
If all you are ranting about is the move from devfs to udevd, then all 
the user land tools dealing with them have been updated already.

What is the real specific problem you are having?

James

