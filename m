Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbRGQKPe>; Tue, 17 Jul 2001 06:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbRGQKPZ>; Tue, 17 Jul 2001 06:15:25 -0400
Received: from ls212.hinet.hr ([195.29.150.91]:55716 "EHLO ls212.hinet.hr")
	by vger.kernel.org with ESMTP id <S264963AbRGQKPT>;
	Tue, 17 Jul 2001 06:15:19 -0400
Date: Tue, 17 Jul 2001 11:46:18 +0200
To: Daniel Lintjens <daniel.lintjens@tasking.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:blinking screen in XFree4.x !
Message-ID: <20010717114618.A773@debelian.doma.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200107170721.JAA0000038245@greve.tasking.nl>
User-Agent: Mutt/1.3.18i
From: Marko Rebrina <mrebrina@jagor.srce.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2001 at 09:21:05AM +0200, Daniel Lintjens wrote:
> Hi Marko,
> Do you have a via chipset ? If so, you stumbled on the via timer bug. Don't 

Yes.

> know much about it, but apparently the timer in some situation gives 
> garbage, causing the screensave of x to kick in. Try disabling the X 
> screensavers (within gnome/kde usualy), that worked for me. Since kernel 

I don't have screensaver!

> 2.4.3 I haven't seen this behavior btw, but I have upgraded so (X, the 
> kernel, the sblive driver, the bttv driver ...) 
> I don't know the version of the kernel that adressed this issue, (it 
> appeared multiple times in the mailing list, and was fixed several times 
> (appeared under different situations). If nothing works, try not using the 
> onboard sound and ata100. These apparently trigger the problem.

I don't have onboard sound & ata100

-- 
  -o)      // Marko Rebrina, http://jagor.srce.hr/~mrebrina, ICQ:20358351 \\
  /\\  
 _\_v      Serving FREE beer to the users of the FREE Linux of a FREE world
