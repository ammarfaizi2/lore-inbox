Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270451AbTGSSet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270466AbTGSSet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:34:49 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:65496 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270451AbTGSSet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:34:49 -0400
Date: Sat, 19 Jul 2003 11:49:44 -0700
From: Larry McVoy <lm@bitmover.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper
Message-ID: <20030719184944.GC24197@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307181603340.21716-100000@chimarrao.boston.redhat.com> <1058560325.2662.31.camel@localhost> <20030719184246.GF7452@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030719184246.GF7452@lug-owl.de>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 08:42:46PM +0200, Jan-Benedict Glaw wrote:
> Have you ever used eg. cvsps with the BK->CVS gateway? I tried this and
> failed because of 4 issues:
> 
> 	- I couldn't get the initial import patchset (2)
> 	- I couldn't get two other patchsets
> 	- One patchset added a file which already existed (11504)

Work with Ben Collins on that.  I don't know what cvsps is so I can't
help you there.  If you can figure out what is wrong with the tree and 
explain what we should do to fix it, we'll give it a tree.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
