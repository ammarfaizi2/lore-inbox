Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUJKPxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUJKPxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269078AbUJKPvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:51:09 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:10715 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269059AbUJKPQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:16:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Date: Mon, 11 Oct 2004 17:17:53 +0200
User-Agent: KMail/1.6.2
Cc: "J.A. Magallon" <jamagallon@able.es>
References: <2O5L3-5Jq-11@gated-at.bofh.it> <200410111623.08848.rjw@sisk.pl> <1097504930l.6177l.3l@werewolf.able.es>
In-Reply-To: <1097504930l.6177l.3l@werewolf.able.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410111717.53898.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 of October 2004 16:28, J.A. Magallon wrote:
> 
> On 2004.10.11, Rafael J. Wysocki wrote:
> > On Monday 11 of October 2004 16:12, J.A. Magallon wrote:
> > > 
> > > On 2004.10.11, Rafael J. Wysocki wrote:
> > > > On Monday 11 of October 2004 14:40, Andi Kleen wrote:
> > > > > Tim Cambrant <cambrant@acc.umu.se> writes:
> > > > > 
> > > > > > On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
> > > > > >>
> > > > > >> optimize-profile-path-slightly.patch
> > > > > >>   Optimize profile path slightly
> > > > > >>
> > > > > >
> > > > > > I'm still getting an oops at startup with this patch. After 
reversing
> > > > > > it, everything is fine. Weren't you supposed to remove that from 
your
> > > > > > tree until it was fixed?
> > > > > 
> > > > > There's a fixed version around. I thought Andrew had merged that 
one?
> > > > [-- snip --]
> > > > 
> > > > This one does not apply to -mm.
> > > > 
> > > 
> > > Use this:
> > [-- snip --]
> > 
> > This one does not apply too.
> > 
> 
> Uh ? What are you patching ?
> I had just used and booted it, and I have now saved my own mail received
> from LKML to check if my mailer had been playin with it, and it patches 
fine.
> Sure you applied -mm1 before ? Is you mailer changing tabs to spaces or
> wrapping lines ?

Ahh, it's on top of optimize-profile-path-slightly.patch, not instead of it 
(Andi's patch was meant to be instead of it).  Applied.

Thanks,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
