Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTIAPq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbTIAPq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:46:58 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:32490 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262934AbTIAPq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:46:56 -0400
Date: Mon, 1 Sep 2003 08:46:46 -0700
From: Larry McVoy <lm@bitmover.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Larry McVoy <lm@bitmover.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, ak@suse.de
Subject: Re: bitkeeper comments
Message-ID: <20030901154646.GB1327@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, ak@suse.de
References: <1062389729.314.31.camel@cube> <20030901140706.GG18458@work.bitmover.com> <1062430014.314.59.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062430014.314.59.camel@cube>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 11:26:55AM -0400, Albert Cahalan wrote:
> I'm OK with whatever ensures that somebody looking back
> through the BitKeeper logs isn't going to come to the
> conclusion that I broke something.
> 
> Um, not everybody will grab updates from bkbits.net,
> right? Pardon me for being clueless about BitKeeper,
> but is there some command Andi or Linus could run?

Unfortunately the checkin comments themselves are not revision controlled.
You have to run a command on each repository that needs to be fixed,
if you send me the desired comments I'll post the command.  Then if
Linus or Marcelo says do it I'll do it on bkbits.net.  That should be good
enough, the logs there are what people tend to browse.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
