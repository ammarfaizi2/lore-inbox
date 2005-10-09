Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVJIXnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVJIXnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 19:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVJIXnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 19:43:31 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:47554 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932304AbVJIXna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 19:43:30 -0400
Subject: Re: [swsusp] separate snapshot functionality to separate file
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Lorenzo Colitti <lorenzo@colitti.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051006082050.GA10865@openzaurus.ucw.cz>
References: <20051004205334.GC18481@elf.ucw.cz>
	 <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz>
	 <434443D9.3010501@colitti.com> <20051005224418.GA22781@elf.ucw.cz>
	 <4344599B.7060308@colitti.com> <20051005225727.GE22781@elf.ucw.cz>
	 <20051005230045.GA22906@elf.ucw.cz> <43445F51.7090403@colitti.com>
	 <4344F820.6010701@gmail.com>  <20051006082050.GA10865@openzaurus.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128901281.4747.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 10 Oct 2005 09:41:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

On Thu, 2005-10-06 at 18:20, Pavel Machek wrote:
> Hi!
> 
> > >>"Cool, so you have done 100% of work and now it is stable, fast and
> > >>tested. You only need to do 200% more work to get it merged".
> > >>
> > >>Merging into kernel is not easy, sorry.
> > >> 
> > >It works, it's fast, it's stable, and it does what users want. 
> > >That's a strong combination. It would be really good if you could 
> > >work together to merge it.
> 
> > I've read this thread...
> > And I want to join this request...
> > 
> > It might be that suspend2 is not the best solution, but 
> > maybe if you merge it and then work together in order to 
> > maximize the use of user space at next version, it will be 
> 
> Merge 10000 lines of code, only to drop them in next version?

You're assuming your code would get merged.

More than that, though, let me be bold enough to say that your version
has quite a lot of development to do in order to begin to approach the
level of Suspend2. If and when it achieves that, I'll happily stop
maintaining Suspend2 - after all, I've always said I'm just a user who
wants to suspend. In the meantime, though, I'm happy to carry that can
while you're developing your userspace implementation. That way, users
can have the best of both worlds - a stable, reliable, fast and mature
implementation in kernel space while you're getting userspace working,
and then whatever advantages you bring once your version becomes  an
improved version of Suspend2.

Regards,

Nigel
 


