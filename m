Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTICSH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTICSGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:06:45 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:38105 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264146AbTICSGJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:06:09 -0400
Date: Wed, 3 Sep 2003 11:05:47 -0700
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903180547.GD5769@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903180037.GP4306@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The lines of reasoning presented against tightly coupled systems are
> grossly flawed. 

[etc].

Only problem with your statements is that IBM has already implemented all
of the required features in VM.  And multiple Linux instances are running
on it today, with shared disks underneath so they don't replicate all the
stuff that doesn't need to be replicated, and they have shared memory 
across instances.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
