Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTILEnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbTILEnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:43:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30225
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261662AbTILEnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:43:42 -0400
Date: Thu, 11 Sep 2003 21:43:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Cliff White <cliffw@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler policy v15
Message-ID: <20030912044344.GF26618@matchmail.com>
Mail-Followup-To: Cliff White <cliffw@osdl.org>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F608807.9090705@cyberone.com.au> <200309112329.h8BNTPD24967@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309112329.h8BNTPD24967@mail.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 04:29:24PM -0700, Cliff White wrote:
> > Hi,
> > http://www.kerneltrap.org/~npiggin/v15/
> > 
> > This was going to get high res timers, but instead fixed a bug that might
> > be causing a few people oopses. Also very small interactivity tweaks.
> > 
> > I'm starting to work on SMP and NUMA ideas now, so if any interactivity
> > things are bothering you, please tell me soon. I should be getting access
> > to a 32-way NUMA soon, so I'm sort of holding off chaning too much until
> > then.
> > 
> > Enjoy.
> > 
> Are these against 2.6.0-test5-mm1? We're not getting a clean apply over here. 

Try against test5... not -mm.
