Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUJKOYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUJKOYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269013AbUJKOWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:22:47 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:28121 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268989AbUJKOVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:21:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Date: Mon, 11 Oct 2004 16:23:08 +0200
User-Agent: KMail/1.6.2
Cc: "J.A. Magallon" <jamagallon@able.es>, Andi Kleen <ak@muc.de>,
       Tim Cambrant <cambrant@acc.umu.se>, akpm@digeo.com
References: <2O5L3-5Jq-11@gated-at.bofh.it> <200410111538.33299.rjw@sisk.pl> <1097503960l.6177l.0l@werewolf.able.es>
In-Reply-To: <1097503960l.6177l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410111623.08848.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 of October 2004 16:12, J.A. Magallon wrote:
> 
> On 2004.10.11, Rafael J. Wysocki wrote:
> > On Monday 11 of October 2004 14:40, Andi Kleen wrote:
> > > Tim Cambrant <cambrant@acc.umu.se> writes:
> > > 
> > > > On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
> > > >>
> > > >> optimize-profile-path-slightly.patch
> > > >>   Optimize profile path slightly
> > > >>
> > > >
> > > > I'm still getting an oops at startup with this patch. After reversing
> > > > it, everything is fine. Weren't you supposed to remove that from your
> > > > tree until it was fixed?
> > > 
> > > There's a fixed version around. I thought Andrew had merged that one?
> > [-- snip --]
> > 
> > This one does not apply to -mm.
> > 
> 
> Use this:
[-- snip --]

This one does not apply too.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
