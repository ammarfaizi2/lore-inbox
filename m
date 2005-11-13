Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKMWLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKMWLX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVKMWLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:11:23 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57018 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750757AbVKMWLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:11:23 -0500
Date: Sun, 13 Nov 2005 15:11:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       sdietrich@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rt11 Fill out default_simple_type
Message-ID: <20051113221122.GE3839@smtp.west.cox.net>
References: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com> <20051112144816.GA24942@elte.hu> <1131918975.32542.61.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131918975.32542.61.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 10:56:15PM +0100, Thomas Gleixner wrote:
> On Sat, 2005-11-12 at 15:48 +0100, Ingo Molnar wrote:
> > doesnt apply. Also, the set_type line has whitespace damage.
> > 
> > 	Ingo
> 
> I have integrated the initial patch from Tom Rini into the arm generic
> irq patch set.
> 
> http://www.tglx.de/projects/armirq/

Which was from Daniel of cousre.

-- 
Tom Rini
http://gate.crashing.org/~trini/
