Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVCJF4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVCJF4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVCJFzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:55:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:4809 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261724AbVCJFyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:54:18 -0500
Subject: Re: bk commits and dates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503091924170.2530@ppc970.osdl.org>
References: <1110422519.32556.159.camel@gaston>
	 <Pine.LNX.4.58.0503091924170.2530@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 16:49:19 +1100
Message-Id: <1110433759.32524.174.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 19:28 -0800, Linus Torvalds wrote:
> 
> On Thu, 10 Mar 2005, Benjamin Herrenschmidt wrote:
> > 
> > I don't know if I'm the only one to have a problem with that, but it
> > would be nice if it was possible, when you pull a bk tree, to have the
> > commit messages for the csets in that tree be dated from the day you
> > pulled, and not the day when they went in the source tree.
> 
> Nope, that's against how BK works. It's really distributed, so "my" tree 
> has no special meaning, and as such the fact that I pull has no meaning 
> either - it doesn't trigger as anything special.

Yes, but it would be easy to have the messages dated from the day they
are sent :) Even if you put the real commit date in the message itself.
It's really disturbing to receive mails dated a long time in the past
don't you think ?

> The only thing that ends up being special is when it hits the public tree
> which has the trigger to send out the emails. IOW, the date of the _email_
> is special (in that it says when a commit hit the public tree), not not
> the commits changesets themselves.

Yes, but the email gets the old date.

> Now, if James trigger scripts set the date of the email by the date of the 
> commit, that sounds like a misfeature, but you'd better talk to James, not 
> me, since he's the one doing that part..

Hah ok. Which James ?

Ben.


