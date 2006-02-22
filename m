Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWBVNf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWBVNf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWBVNf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:35:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22557 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750989AbWBVNfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:35:55 -0500
Date: Wed, 22 Feb 2006 14:35:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060222133550.GZ8852@suse.de>
References: <89E85E0168AD994693B574C80EDB9C2703758C89@uk-email.terastack.bluearc.com> <20060222133409.GY8852@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222133409.GY8852@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22 2006, Jens Axboe wrote:
> On Wed, Feb 22 2006, Andy Chittenden wrote:
> > Jens
> > 
> > > On Fri, Feb 03 2006, Andy Chittenden wrote:
> > > > Which brings me back to the original problem I reported: 
> > > any progress on
> > > > a patch for that? FYI I often come in the morning to find processes
> > > > killed.
> > > 
> > > Nope sorry, I'll probably get to it at the start of next week.
> > > 
> > > -- 
> > > Jens Axboe
> > > 
> > 
> > Any progress? This is getting very irritating especially when processes
> > get killed during the day when I link a big executable.
> 
> Can you give this a shot? Untested, as I cannot reproduce it here.

Scratch that, it cannot work on all cases (even if it may fix yours).

-- 
Jens Axboe

