Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbTFAP6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbTFAP6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:58:15 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:20935 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264657AbTFAP6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:58:14 -0400
Date: Sun, 1 Jun 2003 09:11:33 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601161133.GC3012@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jonathan Lundell <linux@lundell-bros.com>,
	linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <20030601134942.GA10750@alpha.home.local> <20030601140602.GA3641@work.bitmover.com> <p05210609baffd3a79cfb@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05210609baffd3a79cfb@[207.213.214.37]>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 09:04:22AM -0700, Jonathan Lundell wrote:
> The reason I've liked this format is that it gives me a quick and 
> universal way to find *specific* functions with vi or grep, by 
> searching for "^function_name(".

Exactly.  I thought of making that point in my original posting and 
figured everyone would tell me to use tags and I didn't want to have
to remember all the other reasons I wanted this.

It really is nice knowing that "^function_name(" is the definition.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
