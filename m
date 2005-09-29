Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVI2V4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVI2V4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVI2V4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:56:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751280AbVI2V4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:56:01 -0400
Date: Thu, 29 Sep 2005 14:55:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
In-Reply-To: <20050929213312.GD31516@redhat.com>
Message-ID: <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Dave Jones wrote:
>
> What I find amusing is that it was a patch rejection mail from you
> *years* back (circa 2000 iirc), telling me my pine corrupted whitespace,
> that made me switch MUA ;-)
> 
> All these years later, and it's still buggered ?

Actually, it seems better. It seems to be buggered by default, but it used 
to be that you had to actually recompile pine to make it behave. Now you 
can just disable "strip-whitespace-before-send" and _enable_ 
"quell-flowed-text" and those together seem to do the trick. No extra 
patches or recompiles necessary.

So there's progress. 

Of course, pico is still pico. Which I find a bit sad: my editor of choise 
is still an improved version of uemacs, and pico actually comes from the 
same uemacs history, but has different key-bindings for just enough keys 
to be slightly confusing.

Still, that shared history means that I find pico a lot more to my taste 
than just about any other emailer editor out there. It may have a few 
differences, but it has more things in common..

		Linus
