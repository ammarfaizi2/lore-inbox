Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWIXOiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWIXOiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWIXOiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:38:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:1209 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751101AbWIXOiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:38:51 -0400
Date: Sun, 24 Sep 2006 20:08:38 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH] RCU: various patches
Message-ID: <20060924143838.GA22448@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060923152957.GA13432@in.ibm.com> <20060923185636.GA18156@in.ibm.com> <20060924030106.GA7569@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924030106.GA7569@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 08:31:06AM +0530, Dipankar Sarma wrote:
> On Sun, Sep 24, 2006 at 12:26:36AM +0530, Dipankar Sarma wrote:
> > On Sat, Sep 23, 2006 at 08:59:57PM +0530, Dipankar Sarma wrote:
> > > This patchset consists of various merge candidates that would
> > > do well to have some testing in -mm. This patchset breaks
> > > out RCU implementation from its APIs to allow multiple
> > > implementations, gives RCU its own softirq and finally
> > > lines up preemptible RCU from -rt tree as a configurable
> > > RCU implementation for mainline. Published earlier and
> > > re-diffed against -mm.
> > > 
> > 
> > I forgot that some of the 2.6.18-rc7-mm1 has a few patches
> > that have been merged. So, I should diff against that so that
> > including these in -mm will be easy. Patches will follow tomorrow.
> 
> The latest diffs are here -
> 
> http://www.hill9.org/linux/kernel/patches/2.6.18-rc7-mm1/
> 
> The series file specifies the order.

Please ignore this patchset for a moment. I will resend a more
complete and more tested patchset against 2.6.18-mm1.

Thanks
Dipankar
