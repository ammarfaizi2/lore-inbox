Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVIURk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVIURk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVIURk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:40:56 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:31120 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751304AbVIURk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:40:56 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Wed, 21 Sep 2005 19:36:30 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, len.brown@intel.com,
       Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-ID: <20050921173630.GA2477@localhost.localdomain>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com> <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 09:35:20AM -0700 Linus Torvalds wrote:

> 
> 
> On Wed, 21 Sep 2005, Pavel Machek wrote:
> > 
> > I think you are not following the proper procedure. All the patches
> > should go through akpm.
> 
> One issue is that I actually worry that Andrew will at some point be where 
> I was a couple of years ago - overworked and stressed out by just tons and 
> tons of patches. 
> 
> Yes, he's written/modified tons of patch-tracking tools, and the git 
> merging hopefully avoids some of the pressures, but it still worries me. 
> If Andrew burns out, we'll all suffer hugely.
> 
> I'm wondering what we can do to offset those kinds of issues. I _do_ like 
> having -mm as a staging area and catching some problems there, so going 
> through andrew is wonderful in that sense, but it has downsides.
> 

Morever bugme.osdl.org is severely underworked (acpi being a noteable
exception) and Andrew has stepped in alot there too. Alot of bugs
reported on the mailing list are only followed up by Andrew.

I think he really should receive much more help than he currently does.
