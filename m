Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269077AbUJKP1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbUJKP1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268978AbUJKP0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:26:01 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:24795 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268971AbUJKPT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:19:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Date: Mon, 11 Oct 2004 17:21:35 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>, Tim Cambrant <cambrant@acc.umu.se>, akpm@digeo.com
References: <2O5L3-5Jq-11@gated-at.bofh.it> <200410111538.33299.rjw@sisk.pl> <20041011145022.GA52120@muc.de>
In-Reply-To: <20041011145022.GA52120@muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410111721.35033.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 of October 2004 16:50, Andi Kleen wrote:
> On Mon, Oct 11, 2004 at 03:38:32PM +0200, Rafael J. Wysocki wrote:
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
> 
> You have to revert the previous version first.

I know that.  I should have said that it did not apply _after_ reverting the 
previous version.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
