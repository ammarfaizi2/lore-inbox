Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVCXLFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVCXLFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbVCXLFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:05:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:27884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262443AbVCXLFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:05:05 -0500
Date: Thu, 24 Mar 2005 03:04:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: drm bugs hopefully fixed but there might still be one..
Message-Id: <20050324030421.63d2d670.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503241015190.7647@skynet>
References: <Pine.LNX.4.58.0503241015190.7647@skynet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@linux.ie> wrote:
>
> I've put a couple of patches into my drm-2.6 tree that hopefully fix up
>  the multi-bridge on i915 and the XFree86 4.3 issue.. Andrew can you drop
>  the two patches in your tree.. the one from Brice and the one I attached
>  to the bug? you'll get conflicts anyway I'm sure. I had to modify Brices
>  one as it didn't look safe to me in all cases..
> 
>  I think their might be one left, but I think it only seems to be on
>  non-intel AGP system, as in my system works fine for a combination of
>  cards and X releases ... anyone with a VIA chipset and Radeon graphics
>  card or r128 card.. testing the next -mm would help me a lot..

argh, I just uploaded -mm2, but haven't announced it yet.  I'll resync with
your -bk.

