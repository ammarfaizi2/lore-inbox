Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280480AbRJaUda>; Wed, 31 Oct 2001 15:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280485AbRJaUdV>; Wed, 31 Oct 2001 15:33:21 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:23308 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S280480AbRJaUdR>; Wed, 31 Oct 2001 15:33:17 -0500
Date: Wed, 31 Oct 2001 21:33:45 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031213345.A779@ping.be>
In-Reply-To: <Pine.LNX.4.30.0110312017460.29808-100000@gans.physik3.uni-rostock.de> <Pine.LNX.3.95.1011031143513.21250A-100000@chaos.analogic.com> <20011031142044.D6869@qcc.sk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031142044.D6869@qcc.sk.ca>; from linux-kernel@discworld.dyndns.org on Wed, Oct 31, 2001 at 02:20:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 02:20:44PM -0600, Charles Cazabon wrote:
> Richard B. Johnson <root@chaos.analogic.com> wrote:
> > 
> > That's 6 extra clocks every Hz or 600 clocks per second. By the time
> > you've reached the 497.1 days, you have wasted.... 0xffffffff/6 =
> > 715,827,882 CPU clocks just so 'uptime' is correct?  I don't think
> > so. I'd reboot.
> 
> For proportion:  716 million CPU clocks, on an "average" PC today is
> less than one second of CPU time.  Over the course of 497 days, that's
> not much overhead at all.

Not to mention that it takes alot more clocks to setup and return
from the interupt.


Kurt

