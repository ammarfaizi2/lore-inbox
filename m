Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275314AbTHGNpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275331AbTHGNpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:45:51 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:39892 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S275314AbTHGNpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:45:49 -0400
Date: Thu, 7 Aug 2003 06:45:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jani Monoses <jani@iv.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] bkbits annotated srcs
Message-ID: <20030807134511.GA1089@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org
References: <20030807102214.06223100.jani@iv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807102214.06223100.jani@iv.ro>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 10:22:14AM +0300, Jani Monoses wrote:
> Is there a way of seeing annotated sources of the kernel via the web
> interface? I see it's possible for changesets and I know it's possible
> with bk installed.

To get the annotated listing of the most recent version of any file use
this URL, changing the filename as appropriate:

	http://linux.bkbits.net:8080/linux-2.5/anno/README@+

Note that the "@" may change to a "|" in the future.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
