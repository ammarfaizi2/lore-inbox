Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUEXVRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUEXVRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUEXVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:17:11 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:27083 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264697AbUEXVRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:17:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 24 May 2004 14:16:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <Pine.LNX.4.58.0405241342190.32189@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405241412550.4174@bigblue.dev.mdolabs.com>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0405241304580.4174@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0405241342190.32189@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Linus Torvalds wrote:

> 
> 
> On Mon, 24 May 2004, Davide Libenzi wrote:
> > 
> > IANAL, but I don't think they have to ask. As with GPL, you not required 
> > to sign anything to be able to use the software. By using the software you 
> > agree on the license. By submitting a patch to a maintainer, you agree 
> > with the Developer's Certificate of Origin.
> 
> No, the thing is, we want your name to show up, and we do want you to 
> explicitly state that not only do you know about the license, you also 
> have the right to release your code under the license.
> 
> Yes, that was all implied before. This is nothing new. The only new thing 
> is to _document_ it, and make it _explicit_.
> 
> And that means that submitters should read the DCO, and add the extra 
> line. That's kind of the whole point of it - making a very ingrained and 
> implicit assumption be explicitly documented.
> 
> In other words: this is not about changing the way we work. It's about 
> documenting the things we take for granted. So that outsiders can be shown 
> how it works.

That was what I was implying. Example:

me: Andrew this is the quit-smoking-patch-0.1.diff
Andrew: Where's your signature? Go read Documentation/xxx and repost the signed version
me: Oke doke. Reading ...
me: There you go, here's quit-smoking-patch-0.2.diff with the required signature



- Davide

