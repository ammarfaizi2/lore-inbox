Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSJNMhO>; Mon, 14 Oct 2002 08:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJNMhO>; Mon, 14 Oct 2002 08:37:14 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:38411 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S261613AbSJNMhN>;
	Mon, 14 Oct 2002 08:37:13 -0400
Date: Mon, 14 Oct 2002 14:41:58 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Dave Jones <davej@codemonkey.org.uk>, Rob Radez <rob@osinvestor.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021014144158.A19209@medelec.uia.ac.be>
References: <20021013234308.P23142@flint.arm.linux.org.uk> <Pine.LNX.4.33L2.0210131615480.22520-100000@dragon.pdx.osdl.net> <20021013215726.P16698@osinvestor.com> <20021014101209.A18123@medelec.uia.ac.be> <20021014122239.GA29240@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014122239.GA29240@suse.de>; from davej@codemonkey.org.uk on Mon, Oct 14, 2002 at 01:22:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 01:22:39PM +0100, Dave Jones wrote:

>  > Now I'm still left with my original question: wouldn't it be easier if we
>  > put all watchdog drivers in drivers/char/watchdog/ ?
> 
> I'd say go for it. drivers/char/ is looking quite cluttered, and this
> has the added advantage of decreasing the size of the Config.in and
> config.help files too.

I still see two options:
1) drivers/char/watchdog/
2) drivers/watchdog/

Not sure what's best in this case...

Greetings,
Wim.

