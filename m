Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTDZQim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTDZQim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:38:42 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:16105 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262005AbTDZQik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:38:40 -0400
Date: Sat, 26 Apr 2003 09:50:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Bradford <john@grabjohn.com>, Zack Brown <zbrown@tumblerings.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ChangeLog suggestion
Message-ID: <20030426165037.GB14914@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	John Bradford <john@grabjohn.com>,
	Zack Brown <zbrown@tumblerings.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304260652.h3Q6qJmB000386@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.44.0304260931190.2276-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304260931190.2276-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 09:34:25AM -0700, Linus Torvalds wrote:
> (Even my scripts don't see the full email a large percentage of the time:  
> I end up prettifying the emails for actual application by first removing
> things like "Hi Linus, please apply this" etc which are pointless in the 
> changelog).

I really wish Marcelo would do this or someone would volunteer to clean
up the change log comments.  BitKeeper doesn't have an easy way to 
propogate changes to the checkin comments (they are not currently 
revision controlled).  However, you can change them and someone could
clean up all the crud in the 2.4 tree and we could replace the one
on bkbits with a cleaned up one.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
