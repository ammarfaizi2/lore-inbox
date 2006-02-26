Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWBZXex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWBZXex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWBZXew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:34:52 -0500
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:33968 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751193AbWBZXew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:34:52 -0500
Date: Sun, 26 Feb 2006 18:32:44 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: OOM-killer too aggressive?
To: Andi Kleen <ak@muc.de>
Cc: axboe@suse.de, largret@gmail.com, linux-kernel@vger.kernel.org
Message-ID: <200602261834_MC3-1-B958-4454@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060226203917.GA76858@muc.de>

On Sun, 26 Feb 2006 at 21:39:17 +0100, Andi Kleen wrote:
> On Sun, Feb 26, 2006 at 10:21:52AM -0800, Andrew Morton wrote:
> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > >
> > > Chris Largret is getting repeated OOM kills because of DMA memory
> > > exhaustion:
> > > 
> > > oom-killer: gfp_mask=0xd1, order=3
> > > 
> > 
> > This could be related to the known GFP_DMA oom on some x86_64 machines.
> 
> What known GFP_DMA oom? GFP_DMA allocation should work.

        http://marc.theaimsgroup.com/?t=113895864600001&r=1&w=2
        http://marc.theaimsgroup.com/?t=113766047000002&r=1&w=2

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

