Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264688AbUEXUqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbUEXUqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264691AbUEXUqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:46:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:59875 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264688AbUEXUpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:45:52 -0400
Date: Mon, 24 May 2004 13:45:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <Pine.LNX.4.58.0405241304580.4174@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0405241342190.32189@ppc970.osdl.org>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0405241304580.4174@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Davide Libenzi wrote:
> 
> IANAL, but I don't think they have to ask. As with GPL, you not required 
> to sign anything to be able to use the software. By using the software you 
> agree on the license. By submitting a patch to a maintainer, you agree 
> with the Developer's Certificate of Origin.

No, the thing is, we want your name to show up, and we do want you to 
explicitly state that not only do you know about the license, you also 
have the right to release your code under the license.

Yes, that was all implied before. This is nothing new. The only new thing 
is to _document_ it, and make it _explicit_.

And that means that submitters should read the DCO, and add the extra 
line. That's kind of the whole point of it - making a very ingrained and 
implicit assumption be explicitly documented.

In other words: this is not about changing the way we work. It's about 
documenting the things we take for granted. So that outsiders can be shown 
how it works.

		Linus
