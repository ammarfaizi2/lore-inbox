Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVCXREW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVCXREW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbVCXREV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:04:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34257 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262463AbVCXREE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:04:04 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: drm bugs hopefully fixed but there might still be one..
Date: Thu, 24 Mar 2005 09:02:03 -0800
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0503241015190.7647@skynet>
In-Reply-To: <Pine.LNX.4.58.0503241015190.7647@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240902.03808.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 24, 2005 2:33 am, Dave Airlie wrote:
> Hi Andrew, Dave,
>
> I've put a couple of patches into my drm-2.6 tree that hopefully fix up
> the multi-bridge on i915 and the XFree86 4.3 issue.. Andrew can you drop
> the two patches in your tree.. the one from Brice and the one I attached
> to the bug? you'll get conflicts anyway I'm sure. I had to modify Brices
> one as it didn't look safe to me in all cases..
>
> I think their might be one left, but I think it only seems to be on
> non-intel AGP system, as in my system works fine for a combination of
> cards and X releases ... anyone with a VIA chipset and Radeon graphics
> card or r128 card.. testing the next -mm would help me a lot..

I'm trying to get ahold of one--so hopefully I'll be able to test and fix this 
stuff up when I do.

Jesse
