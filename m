Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265884AbUGEBD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUGEBD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 21:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265885AbUGEBD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 21:03:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35549 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265884AbUGEBD0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 21:03:26 -0400
Date: Sun, 4 Jul 2004 21:34:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Mason <mason@suse.com>
Cc: Rob Mueller <robm@fastmail.fm>, linux-kernel@vger.kernel.org
Subject: Re: Processes stuck in unkillable D state (2.4 and 2.6)\
Message-ID: <20040705003413.GC20847@logos.cnet>
References: <006a01c45de6$e4442930$62afc742@ROBMHP> <1088604723.1589.1387.camel@watt.suse.com> <007901c45ebc$5dc0b730$62afc742@ROBMHP> <1088614262.1589.1395.camel@watt.suse.com> <20040704173936.GA19545@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704173936.GA19545@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:39:36PM -0300, Marcelo Tosatti wrote:
> On Wed, Jun 30, 2004 at 12:51:02PM -0400, Chris Mason wrote:
> > On Wed, 2004-06-30 at 10:58, Rob Mueller wrote:
> > > > Hi, could you please post the full sysrq-t output?
> > > 
> > > Sure. The 2 procs stuck in D state were 5873 and 15071.
> > 
> > Well, you've got two procs waiting for pages but it isn't entirely clear
> > why they aren't getting them.  There have been quite a few fixes in this
> > area since 2.6.4, how hard is it for you to upgrade?
> 
> Chris,
> 
> However the said should not be present in v2.4, right?

Ugh, I meant, "however said bug (which affects v2.6.4-earlier) did not 
exist in v2.4", so, what would be causing the eternal "D" processes on v2.4 ?

