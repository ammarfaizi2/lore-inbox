Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTLAWVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTLAWVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:21:06 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:27604 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264245AbTLAWUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:20:39 -0500
Date: Mon, 1 Dec 2003 14:20:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
Message-ID: <20031201222025.GA6152@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nathan Scott <nathans@sgi.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20031201062052.GA2022@frodo> <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet> <20031201221058.GA621@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201221058.GA621@frodo>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 09:10:58AM +1100, Nathan Scott wrote:
> > Nathan, 
> > 
> > I think XFS should be a 2.6 only feature.
> > 
> > 2.6 is already stable enough for people to use it. 
> > 
> 
> Hi Marcelo,
> 
> Please reconsider 

I have no idea if XFS should or should not go in, I'm not commenting on that.

However, having a bunch of XFS users say "put it in" when the maintainer
said no, DaveM said no, and no other file system people seem to be
stepping up to the bat with a review and a nod seems wrong.  

Have you spoken with the people who maintain the generic parts of the
VFS layer that you want to change?  If those people were in the list of
people saying "XFS should go in" then I think you'd get a lot farther.

It's great that there are XFS users but the users should not make the add
it or not add it decision, the people who maintain those interfaces which
are generic should make that decision.  Don't you agree?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
