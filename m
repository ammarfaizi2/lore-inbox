Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318833AbSHWO0v>; Fri, 23 Aug 2002 10:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318835AbSHWO0v>; Fri, 23 Aug 2002 10:26:51 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:8467 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318833AbSHWO0t>; Fri, 23 Aug 2002 10:26:49 -0400
Date: Fri, 23 Aug 2002 15:30:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Federico Di Gregorio <fog@initd.org>
Cc: faith@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830m backport (2.5 -> 2.4)
Message-ID: <20020823153057.A18848@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Federico Di Gregorio <fog@initd.org>, faith@valinux.com,
	linux-kernel@vger.kernel.org
References: <1030109549.1120.86.camel@momo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030109549.1120.86.camel@momo>; from fog@initd.org on Fri, Aug 23, 2002 at 03:32:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 03:32:28PM +0200, Federico Di Gregorio wrote:
> hi,
> 
> this is my first try at a kernel patch, i hope i am doing everything
> right; if not, please just tell me. (i sent this patch to both the drm
> maintainer and the linux-kernel ML. should i send 2.4 patches directly
> to marcelo? mm..) 
> 
> anyway, this is just a backport of the 2.5 DRM driver for Intel 830M to
> the 2.4 series. It is against 2.4.19 but, consisting only of added files
> it should work clean on later kernels (tested on 2.4.20pre). The patch
> is quite big (67252 bytes) and can be downloaded from:

Please don't do this.  The 2.5 drm code is a piece of shit and even crappier
than the one in 2.4.

Alan, is there any chance you could send marcelo the -ac drm code?

