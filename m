Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUHaUxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUHaUxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHaUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:53:44 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:43272 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S269161AbUHaUwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:52:36 -0400
Date: Tue, 31 Aug 2004 13:52:11 -0700
To: Diego Calleja <diegocg@teleline.es>
Cc: Jeff Garzik <jgarzik@pobox.com>, bhuey@lnxw.com, torvalds@osdl.org,
       tmv@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Userspace file systems & MKs (Re: silent semantic changes with reiser4)
Message-ID: <20040831205211.GA23395@nietzsche.lynx.com>
References: <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org> <413400B6.6040807@pobox.com> <20040831053055.GA8654@nietzsche.lynx.com> <4134131D.6050001@pobox.com> <20040831155613.2b25df1e.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831155613.2b25df1e.diegocg@teleline.es>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 03:56:13PM +0200, Diego Calleja wrote:
> El Tue, 31 Aug 2004 01:56:45 -0400 Jeff Garzik <jgarzik@pobox.com> escribi?:
> > messaging passing is also known as "really slow C function calls"
> > 
> > My PCI bus passes messages all the time.  A message is in the eye of the 
> > beholder.
> 
> There're some numbers for that:
> 
> http://lists.freebsd.org/pipermail/freebsd-hackers/2003-August/002426.html

As you can see the numbers are very fast for a general purpose system
like that. Add that with their XIO framework for data propagation and
you have a really amazingly fast system that combines both aggressive
design and optimized low level facilities for both remote and local
commuication.

Matt's one of the very few open source engineers on this planet that
can do both well.

bill

