Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUHLXc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUHLXc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268880AbUHLXc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:32:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61929 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268877AbUHLXcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:32:13 -0400
Date: Thu, 12 Aug 2004 19:17:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Charlie Brej <brejc8@vu.a.la>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reproducable user mode system hang
Message-ID: <20040812221704.GB24479@logos.cnet>
References: <411BC339.30504@vu.a.la> <20040812190444.GC23182@logos.cnet> <411BDF73.2090600@vu.a.la>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BDF73.2090600@vu.a.la>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 10:21:55PM +0100, Charlie Brej wrote:
> Marcelo Tosatti wrote:
> >Can you get any kind of trace (ctrl+sysrq+p or NMI oopser) ? 
> 
> I will be able to tell you tomorrow when I get back to work
> 
> > And also make sure to rerun the tests with newer v2.6's.
> 
> Well you are right. It seems to be either fixed in the newer kernel or not 
> effecting the newer kernel. These two both worked fine with the redhat 
> compiled 2.6.7:
> 
> Linux solem.cs.man.ac.uk 2.6.7-1.517 #1 Wed Aug 11 16:28:33 EDT 2004 i686 
> athlon i386 GNU/Linux
> Linux hilly.house 2.6.7-1.517 #1 Wed Aug 11 16:28:33 EDT 2004 i686 i686 
> i386 GNU/Linux
> 
> Did you have an idea of what was causing this?

Not a clue - but it seems to be fixed in recent kernels :)
