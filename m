Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWFTRxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWFTRxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWFTRxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:53:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25102 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750741AbWFTRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:53:35 -0400
Date: Tue, 20 Jun 2006 18:53:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Message-ID: <20060620175321.GA7463@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Ben Collins <bcollins@ubuntu.com>,
	Jody McIntyre <scjody@modernduck.com>,
	Andrew Morton <akpm@osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:14:45PM -0700, Linus Torvalds wrote:
> I want them to tell me what they are sending, so that _when_ I pull, I can 
> line up the result of that pull with the mail they sent, and I can tell 
> "ok, that's actually what the other side intended".

Given that you've complained about me sending daily pull requests
already, how do you intend folk to handle the situation where they've
sent you a pull request, it's apparantly been ignored, and they update
the tree from which you pull (maybe for akpm's benefit) and then you
eventually get around to pulling it a couple of days later?

Given your complaint and your comments above, I can only assume that
I must not touch a tree which I've asked you to pull for 48 hours
just in case you do decide to honour the pull request.

If that's not the case, we need something in place so we know what
your intentions are.  Or we just say "sod it, we'll update the tree
anyway and see what happens, and send an updated request after 48
hours."

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
