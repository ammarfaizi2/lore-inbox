Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbTICSTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264179AbTICSSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:18:13 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:27866 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264191AbTICSQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:16:54 -0400
Date: Wed, 3 Sep 2003 11:15:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903181552.GF5769@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903181550.GR4306@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 11:15:50AM -0700, William Lee Irwin III wrote:
> Independent operating system instances running under a hypervisor don't
> qualify as a cache-coherent cluster that I can tell; it's merely dynamic
> partitioning, which is great, but nothing to do with clustering or SMP.

they can map memory between instances
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
