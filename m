Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129372AbRCHSJp>; Thu, 8 Mar 2001 13:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbRCHSJg>; Thu, 8 Mar 2001 13:09:36 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129283AbRCHSJP>; Thu, 8 Mar 2001 13:09:15 -0500
Date: Thu, 8 Mar 2001 13:07:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: Microsoft begining to open source Windows 2000?
In-Reply-To: <Pine.LNX.4.32.0103081124210.9614-100000@viper.haque.net>
Message-ID: <Pine.LNX.3.95.1010308125651.2984A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Mohammad A. Haque wrote:

> On Thu, 8 Mar 2001, Venkatesh Ramamurthy wrote:
> 
> > My initial thought after seeing this article was that microsoft was testing
> > its waters on open sourcing. If i have 1500 licenses then i would get the
> > source. If i find any bug in thier source , i  would report to microsoft or
> > send a patch and they would put it in thier next version. Is this not the
> > same way Linux Kernel is developed?. Only thing microsoft does not want to
> > immediately go full open sourcing and get embarrased at the hands of linux
> > people.
> >
> 
> making a patch means you've modfied the source which you are not allowed
> to do. The most you can do is report the bug through normal channels
> (you dont even have priority in reporting bugs since you have the code).
> 
> at least _ANYONE_ was able to contribute to linux. not just people with
> gobs of money. I'm not even gonna comment on the embarrasement bit. The
> one consultant quoted in the article summed it pretty nicely.
> 
> Also notice that you're now paying MS so you can find their bugs. Very
> nice.

Of course Microsoft, being the industry leader and producer of
the world's most powerful operating system, could not possibly
have any bugs or even room for improvement. Therefore, revealing
their exquisite source code is only being done to educate those
who have not yet achieved Microsoft's pinnacle of perfection.

Sorry, I couldn't resist. FYI, I doubt that much actual code
will be revealed because this could open the door to many lawsuits
having to do with stolen intellectual property. Instead, they
will probably define some MACROS like:

	START_OS();
	RUN_OS();
	STOP_OS();

These are just dummies. The most important is a callable procedure:

		make_blue_screen_of_death();


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


