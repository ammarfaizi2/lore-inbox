Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVCWSf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVCWSf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVCWSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:35:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19692 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261786AbVCWSfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:35:53 -0500
Date: Wed, 23 Mar 2005 19:33:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Seger <Mark.Seger@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for inconsistent recording of block device statistics
Message-ID: <20050323183329.GG16149@suse.de>
References: <42409313.1010308@hp.com> <20050323091916.GO24105@suse.de> <42417FE3.2090506@hp.com> <20050323155150.GE16149@suse.de> <4241B407.4070700@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4241B407.4070700@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2005, Mark Seger wrote:
> 
> >>re: your patch - I did try it on both an Operton and Xeon box.  It 
> >>worked find on the Opeteron and reported 0 for all the sectors on the 
> >>Xeon.  If nothing immediately jumps to your mind could it have been 
> >>something I did wrong?  I'll try another build after I send this along, 
> >>but I don't see how that will help as I did the first one from a brand 
> >>new source kit.
> >>   
> >>
> >
> >Sounds very strange, it is generic code so should work for all.
> >Different storage?
> > 
> >
> Works fine now.  Obviously I screwed up something and just wanted to let 
> you know it was cockpit error on my end.
> Is your plan to move this into some future kernel?  Do you need anything 
> more from me at this point?

Yes, I will make sure it gets committed. Thanks for your help so far.

-- 
Jens Axboe

