Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTLBSEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLBSDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:03:25 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:46822 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262603AbTLBSDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:03:19 -0500
Date: Tue, 2 Dec 2003 10:02:51 -0800
From: Larry McVoy <lm@bitmover.com>
To: Murthy Kambhampaty <murthy.kambhampaty@goeci.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
Message-ID: <20031202180251.GB17045@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
	'Marcelo Tosatti' <marcelo.tosatti@cyclades.com>,
	Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	Andrew Morton <akpm@osdl.org>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 12:45:38PM -0500, Murthy Kambhampaty wrote:
> If you can't come up with something more concrete than "I don't like your
> coding style" and "I'm not sure your patch won't break something", it seems
> only fair you take the XFS patches.

Not your call, it's Marcelo's call.  And I and he have both suggested
that the way to get XFS in is to have someone with some clout in the file
system area agree that it is fine.  It's a perfectly reasonable request
and the longer it goes unanswered the less likely it is that XFS will get
integrated.  The fact that $XFS_USER wants it in is $XFS_USER's problem.
$VFS_MAINTAINER needs to say "hey, this looks good, what's the fuss about?"
and I suspect that Marcelo would be more interested.

It is not, however, any more my call to make than it is your call to make.
We're not doing Marcelo's job.

It is also not unreasonable to reject a set of changes right before
freezing 2.4.  2.4 is supposed to be dead.  Add XFS and what's next?
Who's pet feature needs to go in?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
