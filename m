Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269583AbRHQDsl>; Thu, 16 Aug 2001 23:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269569AbRHQDsc>; Thu, 16 Aug 2001 23:48:32 -0400
Received: from mail2.eznet.net ([209.105.128.7]:7954 "HELO mail2.eznet.net")
	by vger.kernel.org with SMTP id <S269583AbRHQDsS>;
	Thu, 16 Aug 2001 23:48:18 -0400
Message-ID: <3B7C9468.91A73E97@eznet.net>
Date: Thu, 16 Aug 2001 23:50:00 -0400
From: "David A. Frantz" <wizard@eznet.net>
Reply-To: wizard@eznet.net
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en-US, en, fr, es, ko, ja, de, nl, zh
MIME-Version: 1.0
To: fattymikefx@yahoo.com
Subject: Re: installing .01
In-Reply-To: <20010817031904.3DFEF501D7@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tristan;

kernel 0.01 is well before my Linux time, so I can't help with that at all.
What I can suggest is that you get a version fo Redhat up and running on your
PC.    Then install find a Virtual Machine system that will allow you to install
another version of linux that you can run in a VM session.    Use this image as
your learning environment.    All that having been said, do understand that I've
never done this, so others may have comments that are more relavant.

MY thoughts are these:
First; the kernel is constant being updated.   Your best bet to get relavant help
with any thing is to be working on current sources.
Second; many of the tools that are shipped with Linux are vastly improved in
thier later revisions.   Using these tools should result in an over all better
experience.
Third; the quality of the kernel is constantly improving.   This improved kernel
should serve as a solid base to learn about operating systems on.

Thanks
Dave


tristan wrote:

> Hi,
>
> i just recently joined this mailing list because i need help.
> And Linus suggested i join the kernel mailing list, and quote
> his email to me as a starting point.
> I want to install the linux kernel 0.01 on my 386 machine, and im
> lost on how to do it.
> I am 16 and only worked with linux for the last two years.
> I see running .01 on my 386 as a learning experience into
> the depths of the machine, and how to use assembly and work on
> OSs. So i need some help here is what Linus told me:
>
> >
> > i would like to run linux on it. Im sure there are old distios i could find
> > to install on the machine but i would have much more fun learning about
> > the OS by install the .01 version of the kernel on the system, deleteing
> > DOS and Windows 3.1 which are currently stinking up the computer.
> > The problem is im not sure how to do this, and i cant find any documentation
> > on installing a linux kernel unless i already have linux running.
>
> Well, historically in order to be able to install the 0.01 kernel, you had
> to have a full minix-386 distribution - that was the only way to make the
> filesystem, and to copy the necessary files over etc.
>
> And quite frankly, it's been ten years for me too, so I don't remember all
> the details.
>
> You probably don't have access to minix-386 anyway, so I suspect that
> what you _should_ do is try to use a newer version of Linux to bootstrap
> with. You need a really old compiler to compile Linux-0.01 with - I think
> it needs gcc-1.40 or similar. It simply won't compile with newer
> compilers.
>
> All in all, yes, it can be done. I haven't done it personally in ten
> years, and never hosted from Linux, though. I suspect your best option
> would be to try to get a discussion going on how to do all this on the
> kernel mailing list or similar, feel free to quote this email as a
> starting point.
>
>                         Linus
>
>         I hope some one on this list can help me. If anyone has any
> information of helpfulness i would greatly appreciate it.
>
> Thank you,
> Tristan Sloughter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

