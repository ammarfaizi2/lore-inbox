Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVBBXfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVBBXfI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVBBXek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:34:40 -0500
Received: from S010600c0f014b14a.ss.shawcable.net ([70.64.60.7]:19727 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S262718AbVBBX1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:27:43 -0500
Date: Wed, 2 Feb 2005 17:27:25 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Copyright / licensing question
Message-ID: <20050202232725.GA6197@discworld.dyndns.org>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <20050202144915.94462.qmail@web42106.mail.yahoo.com> <1107385864.21196.632.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107385864.21196.632.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 2005-02-02 at 06:49 -0800, Frank klein wrote:
> > I am having some licensing questions. It would be
> > really great if you can clarify on them
> > 
> > 1. For explaining the internals of a filesystem in
> > detail, I need to take their code from kernel sources
> > 'as it is' in the book. Do I need to take any
> > permissions from the owner/maintainer regarding this ?
> > Will it violate any license if reproduce the driver
> > source code in my book ??
> 
> Legally, not if you mention the licence of the code clearly. 

I'm not sure that's the case.  Inclusion of significant chunks of source code
(not just a dozen lines or whatever) might bring the book into "derived work"
territory, and your publisher is almost certainly not going to allow
redistribution under the GPL ...

The short answer is "ask a lawyer".

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
