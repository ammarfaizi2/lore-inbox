Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932777AbWBUVFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbWBUVFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWBUVFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:05:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:33030 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932777AbWBUVFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:05:07 -0500
Date: Tue, 21 Feb 2006 22:00:51 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.33-pre2
Message-ID: <20060221210051.GA13900@w.ods.org>
References: <20060221214844.GA22561@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221214844.GA22561@dmt.cnet>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Tue, Feb 21, 2006 at 03:48:44PM -0600, Marcelo Tosatti wrote:
> Hi,
> 
> Here goes the second -pre of v2.4.33, containing a small number of
> changes.
> 
> Most notably three security corrections, and an overflow fix for
> machines with large amounts of memory and inodes (which would cause the
> system's logic to reclaim inodes with highmem pages attached to fail).

I will release -hf32.3 shortly (well, I should be careful, each time I
expect something to be done within a few days, I lose).

> Willy Tarreau:
>       Merge branch 'master' of /data/projets/git/linux/linux-2.4
>       Merge branch 'master' of /data/projets/git/linux/linux-2.4

Sorry for this pollution, I thought it would stay local :-(
Next time, I'll try to proceed differently. I think I first pushed the
changes then updated the tree, while perhaps I should have updated it
first.

Regards,
Willy

