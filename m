Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTIASaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTIASaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:30:17 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:499
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S263400AbTIAS30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:29:26 -0400
Date: Mon, 1 Sep 2003 17:58:50 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ian Kumlien <pomac@vapor.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [SHED] Questions.
Message-ID: <20030901155850.GD2359@wind.cocodriloo.com>
References: <1062324435.9959.56.camel@big.pomac.com> <1062373274.1313.28.camel@boobies.awol.org> <1062374409.5171.194.camel@big.pomac.com> <200309011250.48238.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309011250.48238.kernel@kolivas.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 12:50:48PM +1000, Con Kolivas wrote:
> On Mon, 1 Sep 2003 10:00, Ian Kumlien wrote:
> > On Mon, 2003-09-01 at 01:41, Robert Love wrote:

[ big snip ]
 
> > Well, there is latency and there is latency. To take the AmigaOS
> > example. Voyager, a webbrowser for AmigaOS uses MUI (a fully dynamic gui
> > with weighted(prioritized) sections) and renders images. It's responsive
> > even on a 40mhz 68040 using Executive with the feedback scheduler.
> 
> Multiple processors to do different tasks on amigas kinda helped there...

Amiga had just one multipurpose CPU. All other processors were
completelly specialized. It was just that one of these, the blitter,
could be used as a generic "memcpy on steroids" processor, allowing
you to mix 3 sources with shifting and logical operations onto one
destination.
 
> > 500 mhz is a lot of horsepower when it comes to playing mp3's and
> > scheduling.. It feels like something is wrong when i see all these
> > discussions but i most certainly don't know enough to even begin to
> > understand it. I only tried to show the thing i thought was really wrong
> > but you do have a point with the runqueues and timeslices =P
> 
> Things are _never ever ever ever_ as simple as they appear on the surface.

This is SOOOO true :)
 
Greets, Antonio.
