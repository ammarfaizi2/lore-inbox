Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbRFBVjX>; Sat, 2 Jun 2001 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbRFBVjH>; Sat, 2 Jun 2001 17:39:07 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:9476 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261562AbRFBVif>;
	Sat, 2 Jun 2001 17:38:35 -0400
Message-ID: <20010602134003.A183@bug.ucw.cz>
Date: Sat, 2 Jun 2001 13:40:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sun Qingwei <sunqw@ns.lzb.ac.cn>, bug-sh-utils@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Date goes four times faster!
In-Reply-To: <Pine.LNX.4.21.0105310046440.21295-100000@eggplant.lzb.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0105310046440.21295-100000@eggplant.lzb.ac.cn>; from Sun Qingwei on Thu, May 31, 2001 at 01:21:49AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm using Redhat linux 7.0 on an HP vectra vei8-Piii450 computer. My
> desktop environment is Gnome 1.2.1.
> This noon I found that the date went four times faster! It was going well
> before about 11 PM Wen May 30. But after that the date

:-) On my system, date likes to go 3 times slower when I do heavy
scrolling. Maybe we should teach our computers to do something in the
middle ;-).
								Pavel

> displayed by commod "date" accelerated. It told me Thu May 31 00:54:52 CST
> 2001 while my watch was Wen May 30 17:40. 
> Also the "clock" applet on the Panel of Gnome told me 12:57 AM Thu
> May 31!

Can you do cat /proc/interrupts; sleep 1; cat /proc/interrupts?
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
