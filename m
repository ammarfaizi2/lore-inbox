Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272118AbRIRP0e>; Tue, 18 Sep 2001 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRIRP0X>; Tue, 18 Sep 2001 11:26:23 -0400
Received: from lilly.ping.de ([62.72.90.2]:35342 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S272118AbRIRP0M>;
	Tue, 18 Sep 2001 11:26:12 -0400
Date: 18 Sep 2001 17:25:29 +0200
Message-ID: <20010918172529.A6698@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
In-Reply-To: <20010918171416.A6540@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010918171416.A6540@planetzork.spacenet>; from jogi@planetzork.ping.de on Tue, Sep 18, 2001 at 05:14:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:14:16PM +0200, jogi@planetzork.ping.de wrote:
> Hello Andrea,
> 
> I gave your new vm a try and I have to report a problem. System is an
> Athlon 1200 with 256MB memory. Workload:

Sorry to follow up on my own. But the problem seems to be worse than I
first thought. Kernel build is the first thing I test when I try a new
kernel :-)

So now I logged into X and even during starting of Mozilla or normal
web browsing alsaplayer is skiping *lots*. The system is not into swap
and has about 150MB cached. Just to let you know ...

I guess I will go back to -pre10 now. If you want to let me test some
things just let me know.

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
