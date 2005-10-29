Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVJ2VME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVJ2VME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVJ2VMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 17:12:03 -0400
Received: from waste.org ([216.27.176.166]:33152 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751229AbVJ2VMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 17:12:02 -0400
Date: Sat, 29 Oct 2005 14:06:43 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
Message-ID: <20051029210643.GR4367@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain> <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain> <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain> <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 05:06:21PM -0400, Steven Rostedt wrote:
> 
> I already posted this patch to Matt and LKML, but I'm posting it again
> incase anyone else has this problem using ketchup on 2.6.14 from nothing,
> and does a google looking for a fix.

This needs a more robust fix. Like perhaps passing --strip-components
to tar.

-- 
Mathematics is the supreme nostalgia of our time.
