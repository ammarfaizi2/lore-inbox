Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbUEWTUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUEWTUx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUEWTUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:20:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:42911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263419AbUEWTUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:20:52 -0400
Date: Sun, 23 May 2004 12:20:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <Pine.LNX.4.58.0405231159240.512@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0405231218110.25502@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
 <Pine.LNX.4.58.0405231159240.512@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 May 2004, Davide Libenzi wrote:
> 
> Andrew already puts the "From:" thing in the patch comment, so this should 
> be simply a matter of replacing "From:" with "Signed-off-by:", preserving 
> it in logs, and documenting the thing in the patch submission doc. No?

Yes and no.

Right now it is _Andrew_ that does the From: line from you. In the 
sign-off procedure, it would be _you_ who add the "Signed-off-by:" line 
for yourself.

(And then Andrew would sign off on the fact that you signed off).

Not a big difference, I agree. 

		Linus
