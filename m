Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280476AbRJaUUa>; Wed, 31 Oct 2001 15:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280486AbRJaUUU>; Wed, 31 Oct 2001 15:20:20 -0500
Received: from sal.qcc.sk.ca ([198.169.27.3]:7183 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S280476AbRJaUUL>;
	Wed, 31 Oct 2001 15:20:11 -0500
Date: Wed, 31 Oct 2001 14:20:44 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031142044.D6869@qcc.sk.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110312017460.29808-100000@gans.physik3.uni-rostock.de> <Pine.LNX.3.95.1011031143513.21250A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.95.1011031143513.21250A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Oct 31, 2001 at 02:52:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <root@chaos.analogic.com> wrote:
> 
> That's 6 extra clocks every Hz or 600 clocks per second. By the time
> you've reached the 497.1 days, you have wasted.... 0xffffffff/6 =
> 715,827,882 CPU clocks just so 'uptime' is correct?  I don't think
> so. I'd reboot.

For proportion:  716 million CPU clocks, on an "average" PC today is
less than one second of CPU time.  Over the course of 497 days, that's
not much overhead at all.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
