Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSILPBW>; Thu, 12 Sep 2002 11:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSILPBV>; Thu, 12 Sep 2002 11:01:21 -0400
Received: from pasky.ji.cz ([62.44.12.54]:60920 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S315946AbSILPBV>;
	Thu, 12 Sep 2002 11:01:21 -0400
Date: Thu, 12 Sep 2002 17:06:09 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: zdzichu@irc.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
Message-ID: <20020912150609.GE21715@pasky.ji.cz>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, zdzichu@irc.pl,
	linux-kernel@vger.kernel.org
References: <20020819043941.GA31158@irc.pl> <20020818.213719.117777405.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818.213719.117777405.davem@redhat.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Aug 19, 2002 at 06:37:19AM CEST, I got a letter,
where "David S. Miller" <davem@redhat.com> told me, that...
>    Full IPv6 stack is beeing mantained by USAGI project.
> 
> Yes, and based upon previous attempts to get them to merge their work
> into the mainline, we believe at this point that they actually enjoy
> being a totally seperate project and not merging completely is a
> feature for them.
> 
> USAGI may only accept that comment, and the only way they may
> disprove it is to merge their code to us as we have continually
> requested them to do so.
...

FYI, early at this morning (UTC), Yuji Sekiya <sekiya@sfc.wide.ad.jp> wrote on
the USAGI list:

======

> Is there any chance the work of the USAGI project will
> be included in the vanilla kernel(2.4?/2.5?) in the near
> future? Will we see better ipv6 support in 2.6 ?

Yes, we will send patches to mainline kernel.
At least we will send the below patches by end of Setpember.
We are now working.

- IPv6 default route fix
- Source address seletcion
- Privacy extension
- IPv4/IPv6 double bind
- NDP timer improvement
- IPsec for IPv6

======

So, let's watch them and hope that they will fulfill this and send some usable
patches to you..

PS: Sorry for replying to such an old thread, I only thought that people not
subscribed on the USAGI mailing list may be still interested in this.

-- 
 
				Petr "Pasky" Baudis
 
* ELinks maintainer                * IPv6 guy (XS26 co-coordinator)
* IRCnet operator                  * FreeCiv AI occassional hacker
.
<Beeth> Girls are like internet domain names, the ones I like are already taken.
<honx> Well, you can still get one from a strange country :-P
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
