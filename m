Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270910AbTGQUPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270889AbTGQUPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:15:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28823
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270884AbTGQUPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:15:21 -0400
Date: Thu, 17 Jul 2003 22:31:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030717203105.GI1855@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <20030717154211.GA4280@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717154211.GA4280@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 04:42:12PM +0100, Dave Jones wrote:
> On Thu, Jul 17, 2003 at 12:28:57PM +0200, Andrea Arcangeli wrote:
>  > I already tried it and it doesn't do what I need
> 
> You know where to report bugs...

Hmm I thought it was a feature not a bug or I would have already
reported something ;)

What I need is to set the frequency to around 400mhz when on battery,
but that's not any of the speedstep frequencies, the speedstep
frequencies are too fast (750/1200mhz) or too slow (250mhz). Is it
supposed to work that way?

thanks,

Andrea
