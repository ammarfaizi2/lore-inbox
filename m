Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWFTTec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWFTTec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFTTec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:34:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9747 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750811AbWFTTeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:34:31 -0400
Date: Tue, 20 Jun 2006 20:34:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Message-ID: <20060620193422.GA10748@flint.arm.linux.org.uk>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Ben Collins <bcollins@ubuntu.com>,
	Jody McIntyre <scjody@modernduck.com>,
	Andrew Morton <akpm@osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org> <20060620175321.GA7463@flint.arm.linux.org.uk> <44984CA1.5010308@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44984CA1.5010308@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 09:29:37PM +0200, Stefan Richter wrote:
> Russell King wrote:
> >On Mon, Jun 19, 2006 at 08:14:45PM -0700, Linus Torvalds wrote:
> >>I want them to tell me what they are sending, so that _when_ I pull, I 
> >>can line up the result of that pull with the mail they sent, and I can 
> >>tell "ok, that's actually what the other side intended".
> >
> >Given that you've complained about me sending daily pull requests
> >already, how do you intend folk to handle the situation where they've
> >sent you a pull request, it's apparantly been ignored, and they update
> >the tree from which you pull (maybe for akpm's benefit) and then you
> >eventually get around to pulling it a couple of days later?
> [...]
> 
> I don't maintain git repos myself, but I'd say _branches_ or something 
> like that might be the way to go.

The point was to try to establish when we could consider the tree from
which we'd asked Linus to pull from as being sufficiently old that it
would not be pulled from without another request being sent - or if it
was pulled from, that we wouldn't get an email from Linus about the fact
there was new stuff in there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
