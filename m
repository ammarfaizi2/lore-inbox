Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264413AbTEJPys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTEJPys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:54:48 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:41631 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264413AbTEJPyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:54:14 -0400
Date: Sat, 10 May 2003 09:06:51 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net and BK->CVS gateway
Message-ID: <20030510160651.GA24686@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org
References: <20030510140455.GA23475@work.bitmover.com> <20030510153416.GJ679@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510153416.GJ679@phunnypharm.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 11:34:16AM -0400, Ben Collins wrote:
> > This bad disk is the cause of the CVS gateway being screwed up, we should
> > have that back online tonight or tomorrow.  Sorry about the downtime.
> 
> Any idea if the new repo will be revision compatible with the old bkcvs?
> IOW, will checkouts have to be redone?

It should be 100% compatible, I build the CVS repo here and mirror it to
kernel.bkbits.net.  You should be all set.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
