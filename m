Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268582AbTBYWr6>; Tue, 25 Feb 2003 17:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268583AbTBYWr6>; Tue, 25 Feb 2003 17:47:58 -0500
Received: from bitmover.com ([192.132.92.2]:37051 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268582AbTBYWr5>;
	Tue, 25 Feb 2003 17:47:57 -0500
Date: Tue, 25 Feb 2003 14:58:06 -0800
From: Larry McVoy <lm@bitmover.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Larry McVoy <lm@bitmover.com>, William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225225806.GA12298@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chris Wedgwood <cw@f00f.org>, Larry McVoy <lm@bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1046093309.1246.6.camel@irongate.swansea.linux.org.uk> <20030225051956.GA18302@f00f.org> <20030225052602.GW10411@holomorphy.com> <20030225212115.GB21870@f00f.org> <20030225212134.GD10411@holomorphy.com> <20030225220811.GA9317@work.bitmover.com> <20030225223743.GA22579@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225223743.GA22579@f00f.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... or is this more an artifact that even though the improvements for
> real-world are negligible, micro-benchmarks are susceptible to these
> variations this making things like the std. dev. larger than it would
> otherwise be?

Bingo.  If you are trying to measure whether something adds cache misses
you really want reproducible runs.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
