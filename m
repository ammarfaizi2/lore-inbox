Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUJKOjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUJKOjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUJKOcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:32:23 -0400
Received: from smtp09.auna.com ([62.81.186.19]:59126 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269024AbUJKO2v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:28:51 -0400
Date: Mon, 11 Oct 2004 14:28:50 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc4-mm1
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
References: <2O5L3-5Jq-11@gated-at.bofh.it> <200410111538.33299.rjw@sisk.pl>
	<1097503960l.6177l.0l@werewolf.able.es> <200410111623.08848.rjw@sisk.pl>
In-Reply-To: <200410111623.08848.rjw@sisk.pl> (from rjw@sisk.pl on Mon Oct
	11 16:23:08 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097504930l.6177l.3l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.11, Rafael J. Wysocki wrote:
> On Monday 11 of October 2004 16:12, J.A. Magallon wrote:
> > 
> > On 2004.10.11, Rafael J. Wysocki wrote:
> > > On Monday 11 of October 2004 14:40, Andi Kleen wrote:
> > > > Tim Cambrant <cambrant@acc.umu.se> writes:
> > > > 
> > > > > On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
> > > > >>
> > > > >> optimize-profile-path-slightly.patch
> > > > >>   Optimize profile path slightly
> > > > >>
> > > > >
> > > > > I'm still getting an oops at startup with this patch. After reversing
> > > > > it, everything is fine. Weren't you supposed to remove that from your
> > > > > tree until it was fixed?
> > > > 
> > > > There's a fixed version around. I thought Andrew had merged that one?
> > > [-- snip --]
> > > 
> > > This one does not apply to -mm.
> > > 
> > 
> > Use this:
> [-- snip --]
> 
> This one does not apply too.
> 

Uh ? What are you patching ?
I had just used and booted it, and I have now saved my own mail received
from LKML to check if my mailer had been playin with it, and it patches fine.
Sure you applied -mm1 before ? Is you mailer changing tabs to spaces or
wrapping lines ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


