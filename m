Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289360AbSAJJsI>; Thu, 10 Jan 2002 04:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289361AbSAJJr6>; Thu, 10 Jan 2002 04:47:58 -0500
Received: from pD9E12911.dip.t-dialin.net ([217.225.41.17]:35024 "EHLO
	twinspark.cobolt.net") by vger.kernel.org with ESMTP
	id <S289360AbSAJJru>; Thu, 10 Jan 2002 04:47:50 -0500
Date: Thu, 10 Jan 2002 10:52:10 +0100
From: Dennis Schoen <dennis@cobolt.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: RT8139 Too much work at interrupt, IntrStatus=....
Message-ID: <20020110095210.GA354@cobolt.net>
Reply-To: Dennis Schoen <dennis@cobolt.net>
Mail-Followup-To: Mark Hahn <hahn@physics.mcmaster.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020109090855.GA338@cobolt.net> <Pine.LNX.4.33.0201091759120.22941-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201091759120.22941-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.25i
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

any reason why you posted that to me and not to the list?

On Wed, Jan 09, 2002 at 06:02:10PM -0500, Mark Hahn wrote:
> > yesterday I upgraded a firewall/router of a *busy* customer site
> ...
> > Jan  8 17:07:45 liquice kernel: 8139too: rx stop wait too long
> 
> surely a "*busy*" can pay an extra $20 and get a real network card...
sure, but as I said: with kernel v2.4.7 it works! So I guess it must
be a bug in something later than version 2.4.7.

> > Jan  8 17:07:46 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0050.
> 
> did you happen to enable the use of local apic (in the new kernel's config)?
nope. I'll try that.

Dennis
