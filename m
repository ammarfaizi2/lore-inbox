Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVACSat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVACSat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVACSaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:30:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47378 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261746AbVACSZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:25:50 -0500
Date: Mon, 3 Jan 2005 18:25:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Domen Puncer <domen@coderock.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] maintainers: remove moderated arm list
Message-ID: <20050103182532.A3442@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Domen Puncer <domen@coderock.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20041225170825.GA31577@nd47.coderock.org> <20041225172155.A26504@flint.arm.linux.org.uk> <20050103175438.GL2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050103175438.GL2980@stusta.de>; from bunk@stusta.de on Mon, Jan 03, 2005 at 06:54:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 06:54:38PM +0100, Adrian Bunk wrote:
> On Sat, Dec 25, 2004 at 05:21:55PM +0000, Russell King wrote:
> > If we must, I guess it's fine, but I expect *you* to provide the support
> > to people to people who don't know where to go for it if *you* remove this.
> 
> I'm sometimes doing patches that cover many files, and I want to Cc the 
> patches to the developers in question.
> 
> If after sending 10 patches I get 5 "this is a subscribers-only list" 
> mails, I'm not going to subscribe to 5 lists, forward the patches to 
> them and unsubscribe again after this (and repeat this if there's some 
> discussion regarding one of these patches).
> 
> In my experience, the best solution is a list policy that allows 
> subscribers to post and requires moderator approval for non-members.
> This policy that is already used by several lists listed in MAINTAINERS 
> is IMHO a good compromise between avoiding spam and allowing 
> non-subscribers to post to the list.

Well, that's precisely what happens with these lists - your post ends
up in the moderator approval queue.  They do generally find their way
from there into the appropriate peoples mailboxes (iow, mine).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
