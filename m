Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTAVP3S>; Wed, 22 Jan 2003 10:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTAVP3R>; Wed, 22 Jan 2003 10:29:17 -0500
Received: from bitmover.com ([192.132.92.2]:38098 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261689AbTAVP3P>;
	Wed, 22 Jan 2003 10:29:15 -0500
Date: Wed, 22 Jan 2003 07:38:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030122153822.GA4565@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dana Lacoste <dana.lacoste@peregrine.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <CDEDIMAGFBEBKHDJPCLDCEEKCFAA.huaz@sbcglobal.net> <20030122071028.GA3466@bjl1.asuk.net> <20030122151826.GA23656@work.bitmover.com> <1043249260.1397.200.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043249260.1397.200.camel@dlacoste.ottawa.loran.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 10:27:40AM -0500, Dana Lacoste wrote:
> On Wed, 2003-01-22 at 10:18, Larry McVoy wrote:
> 
> > A boundary is a boundary.  It doesn't matter how much you want or need
> > what is on the other side of that boundary, you don't get to make your
> > license cross that boundary, the law doesn't work that way.
> 
> Thus the concept of "derivative work."

Derivative works don't get to cross boundaries.  A boundary is a trump
card, it's like a patent, it has strength.  Go dig into the legal
findings in this area.  My memory is that anything you can pull out and
replace with another implementation constitutes a boundary and you may
have different licenses on either side of that boundary without fear of
them fighting.  So a derivative work which can't be easily replaced 
doesn't get to have a different license than the basis.  On the other
hand, something which plugs into an interface, like a driver or a 
file system, could have a different license.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
