Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132522AbRAXEoQ>; Tue, 23 Jan 2001 23:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132523AbRAXEoG>; Tue, 23 Jan 2001 23:44:06 -0500
Received: from losp-101.sjc.ca.bbnow.net ([24.219.8.101]:44550 "EHLO
	gateway.przygoda.net") by vger.kernel.org with ESMTP
	id <S132522AbRAXEoA>; Tue, 23 Jan 2001 23:44:00 -0500
Date: Tue, 23 Jan 2001 20:43:48 -0800 (PST)
From: Tomasz Przygoda <tomek@przygoda.net>
To: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: With recent kernels, ThinkPad 600 won't resume for two minutes
 after  suspend
In-Reply-To: <3A6E507F.21E518DE@yahoo.co.uk>
Message-ID: <Pine.LNX.4.30.0101232040450.6250-100000@tomek.home.przygoda.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 600X and 2.2.1[6-8] work just fine.
the only silly thing is I have to switch to text console before sspending
the laptop, otherwise after resume the X looses keyboard and you can
only login from network :(


On Tue, 23 Jan 2001, Thomas Hood wrote:

> Hi.
>
> With recent kernels, my ThinkPad 600 won't resume for two minutes
> after it is suspended.  When the Fn key is pressed the machine
> starts up, the CD-ROM scans, the screen backlight turns on,
> and the APM light flashes.  But then it just stays like that
> instead of restarting the CPU; it is completely hung, although
> the APM light continues to flash.  If I wait more than about
> two minutes with the machine suspended, however, then everything
> resumes normally.
>
> I have been running Linux for two years.  This never happened
> before a couple weeks ago when I upgraded to kernels 2.2.18 and
> then 2.4.0 .  I have since tested kernel 2.2.17 and see the
> same problem.  Do I have a hardware problem, or might something
> have changed in the kernel that could lead to this behavior?
>
> Thomas Hood
> jdthood_AT_yahoo.co.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 
Tomek,
__________________________________________________
Do You Yahoo!?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
