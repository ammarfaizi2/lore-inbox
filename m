Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVKMWMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKMWMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKMWMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:12:50 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:44499
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750763AbVKMWMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:12:49 -0500
Subject: Re: [PATCH] rt11 Fill out default_simple_type
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       sdietrich@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051113221122.GE3839@smtp.west.cox.net>
References: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com>
	 <20051112144816.GA24942@elte.hu>
	 <1131918975.32542.61.camel@tglx.tec.linutronix.de>
	 <20051113221122.GE3839@smtp.west.cox.net>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 13 Nov 2005 23:17:10 +0100
Message-Id: <1131920230.32542.63.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-13 at 15:11 -0700, Tom Rini wrote:
> On Sun, Nov 13, 2005 at 10:56:15PM +0100, Thomas Gleixner wrote:
> > On Sat, 2005-11-12 at 15:48 +0100, Ingo Molnar wrote:
> > > doesnt apply. Also, the set_type line has whitespace damage.
> > > 
> > > 	Ingo
> > 
> > I have integrated the initial patch from Tom Rini into the arm generic
> > irq patch set.
> > 
> > http://www.tglx.de/projects/armirq/
> 
> Which was from Daniel of cousre.

Sorry, was not obvious from the mail and Signed-off lines

	tglx



