Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUHVWmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUHVWmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267604AbUHVWmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:42:44 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:6413 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id S267558AbUHVWml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:42:41 -0400
Date: Sun, 22 Aug 2004 23:42:39 +0100
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com, anton@samba.org, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-ID: <20040822224239.GA98010@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk> <20040821135833.6b1774a8.akpm@osdl.org> <20040821232206.GC20175@compsoc.man.ac.uk> <20040821163628.10cfa049.akpm@osdl.org> <20040821235556.GA22619@compsoc.man.ac.uk> <20040821214141.70eb4b9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821214141.70eb4b9a.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Bz12t-0002gB-L9*yIRSCAhoKbw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 09:41:41PM -0700, Andrew Morton wrote:

> > suite for OProfile, but I don't have one other than the usual by-hand
> > testing I do. Isn't there some STP thing or something at OSDL we can
> > get people to try?
> 
> LTP

FWIW I did some more testing on my 2-way today. I also ran the LTP suite
under heavy OProfile stress without any noticable problems, so at least
basic things like threads work.

regards
john
