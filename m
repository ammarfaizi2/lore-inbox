Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262115AbSJFSeW>; Sun, 6 Oct 2002 14:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbSJFSeW>; Sun, 6 Oct 2002 14:34:22 -0400
Received: from fugazi.engr.arizona.edu ([150.135.83.155]:53123 "EHLO
	fugazi.engr.arizona.edu") by vger.kernel.org with ESMTP
	id <S262115AbSJFSeS>; Sun, 6 Oct 2002 14:34:18 -0400
Date: Sun, 6 Oct 2002 11:42:24 -0700 (MST)
From: Tim Spriggs <tims@fugazi.engr.arizona.edu>
To: Jos Hulzink <josh@stack.nl>
cc: mec@shout.net, <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig problem
In-Reply-To: <20021006090008.UREV2173.amsfep13-int.chello.nl@there>
Message-ID: <Pine.GSO.4.44.0210061141060.24129-100000@fugazi.engr.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you,

  Everything worked well in X.

-Tim

                     < PRE >
##--##--##--##--##--##--##--##--##--##--##--##--##
|             T I M    S P R I G G S             |
|        Assistant Sysadmin - Development        |
|        College of Engineering and Mines        |
|            ECE206A - (520) 621-3185            |
##--##--##--##--##--##--##--##--##--##--##--##--##
                     </PRE >

On Sun, 6 Oct 2002, Jos Hulzink wrote:

> Hi Tim,
>
> Configure the kernel in X (make xconfig) or edit .config by hand. I've
> started looking at this, but I presume one of the ALSA developpers will have
> this minor issue fixed before I even found where to look :)
>
> Jos
>
> On Sunday 06 October 2002 07:06, Tim Spriggs wrote:
> > I got this when I selected the alsa branch of the kernel configuration
> >
> > with kernel 2.5.40:
> > | Menuconfig has encountered a possible error in one of the kernel's
> > | configuration files and is unable to continue.  Here is the error
> > | report:
> > |
> > |  Q> ./scripts/Menuconfig: line 823: MCmenu74: command not found
> > |
> > | Please report this to the maintainer <mec@shout.net>.  You may also
> > | send a problem report to <linux-kernel@vger.kernel.org>.
> > |
> > | Please indicate the kernel version you are trying to configure and
> > | which menu you were trying to enter when this error occurred.
> > |
> > | make: *** [menuconfig] Error 1
> >
> > If there is anything I can do to help fix this, let me know.
> >
> > -Tim
> >
> >                      < PRE >
> > ##--##--##--##--##--##--##--##--##--##--##--##--##
> >
> > |             T I M    S P R I G G S             |
> > |        Assistant Sysadmin - Development        |
> > |        College of Engineering and Mines        |
> > |            ECE206A - (520) 621-3185            |
> >
> > ##--##--##--##--##--##--##--##--##--##--##--##--##
> >                      </PRE >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>

