Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSBOCyX>; Thu, 14 Feb 2002 21:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286413AbSBOCyN>; Thu, 14 Feb 2002 21:54:13 -0500
Received: from ns3.miraclelinux.com ([61.120.40.82]:22261 "EHLO
	dns01.miraclelinux.com") by vger.kernel.org with ESMTP
	id <S286411AbSBOCx7>; Thu, 14 Feb 2002 21:53:59 -0500
To: go@turbolinux.co.jp
Cc: yakker@alacritech.com, jgarzik@mandrakesoft.com,
        lkcd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, davej@suse.de
Cc: hyoshiok@miraclelinux.com
Subject: Re: [lkcd-general] Re: status of LKCD into Linux Kernel
In-Reply-To: <3C6B7B2E.2050500@turbolinux.co.jp>
In-Reply-To: <3C6B51AA.6EB614C3@mandrakesoft.com>
	<3C6B5A2E.2C2637C7@alacritech.com>
	<3C6B7B2E.2050500@turbolinux.co.jp>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020215114220Z.hyoshiok@miraclelinux.com>
Date: Fri, 15 Feb 2002 11:42:20 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks to all.

I has been asked by customers, ISV vendors and many
to support a crash dump facility in the linux kernel.

I'd like to know issues/concerns to be merged the LKCD into
the kernel if any.

By the way, who is the kernel people to maintain a
dump facility? Linus? Dave?

Regards,
  Hiro
--
Hiro Yoshioka/CTO, Miracle Linux
mailto:hyoshiok@miraclelinux.com
http://www.miraclelinux.com

From: Go Taniguchi <go@turbolinux.co.jp>
> At my point of view, LKCD is convinced that it is the most important technology 
> for us.
> 
> It seems to be LKCD is just working perfectly with our 2.4.17 kernel.
> It reduces plenty of time for analysing Oops. Hence,for engineers like us, LKCD 
> is necessary.
> 
> I am really looking forward that LKCD will be merged into Kernel main-tree
>   in the near future. If it is possible that would probably be much better if 
> the user ability and time for analysing can be improved.
> 
> I really appreciate everybody's works in this super team-LKCD.
> 
> Thanks again,
> -- GO!
> 
> Matt D. Robinson wrote:
> 
> > A lot of progress has been made ...
> > 
> > LKCD is currently up to 2.4.17, and should be simple to
> > move into 2.5.
> > 
> > I've asked Linus and others for inclusion in the past, and I
> > think it deserves consideration for 2.5, especially now that it
> > can be built into the kernel without having to be turned on.
> > At least in those cases, people who want it can turn it on,
> > and those that don't will never see it.
> > 
> > The LKCD development team (over 10 engineers now) is ready.
> > 
> > --Matt
> > 
> > Jeff Garzik wrote:
> > 
> >>Hiro Yoshioka wrote:
> >>
> >>>I have a naive question. Will the LKCD be merged into
> >>>the Linus' kernel? If yes, when? wild guess?
> >>>
> >>I talked with Matt Robinson(sp?) at LinuxWorld-NY about LKCD for a few
> >>minutes...  he gave me the impression that a lot of progress has been
> >>made recently.  IBM apparently has some guys working on it, too.
> >>
> >>I've always thought Linux needs industrial strength crash dumps like the
> >>other Unices.  There are many benefits, but my own is self interest:
> >>bug reports get 1000 times better, since you get along with the crash
> >>point a lot more info about the state of the system at the time of the
> >>crash.
> >>
> >>So, I hope LKCD is looked upon favorably by the Penguin Gods. :)
> >>
> >>        Jeff
> >>
> > 
> > _______________________________________________
> > Lkcd-general mailing list
> > Lkcd-general@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/lkcd-general
> > 
> > 
> 
