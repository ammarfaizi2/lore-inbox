Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275817AbRJCEB2>; Wed, 3 Oct 2001 00:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275818AbRJCEBT>; Wed, 3 Oct 2001 00:01:19 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:50868 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S275817AbRJCEBH>; Wed, 3 Oct 2001 00:01:07 -0400
Message-ID: <3BBA8D9E.74ECDE98@idcomm.com>
Date: Tue, 02 Oct 2001 22:01:34 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Best gigabit card for linux
In-Reply-To: <001a01c13fed$ef3806f0$6c01a8c0@ABEPC> <3BAC153A.4060700@osafo.com> <3BBA7767.C99059CB@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Goldberg wrote:
> 
> Hi,
> 
>    I ordered 2 NSC-based giga ethernet cards (copper) and I was able to
> get 54.4 Megabytes/s sustained (between an amd athlon 1200 MHz and an
> athlon 1000 MHz) on kernel v2.4.5.
> 
>   Since these card cost $45 each, i HIGHLY recommend them.  The actualy
> manufacturer is a company called Cameo in Taiwan.

Are those available in 64 bit pci slot format? I assume for that price
they run in 32 bit slots (which is no doubt a bottleneck on a real
gigabit).

D. Stimits, stimits@idcomm.com

> 
>  --Seth
> 
> Colin Frank wrote:
> >
> > In the following test. I was able to achieve close to 40 MegaBytes
> > per second using the packet engines Hamachi driver.
> >
> > http://www.linuxcare.com/labs/sol-val/3w-esc6800-web.epl
> > Test done with:
> >     Packet engines Hamachi card
> >     3ware escalade 6800
> >     2.2.16 kernel.
> >     Cisco 6500
> >     10 - 20 client machines each with eepro100 cards
> >
> > Colin...
> >
> > Abe Hayhurst wrote:
> >
> > >Hi Alan,
> > >
> > >I wanted to know your opinion as to which combination of gigabit cards (both
> > >fiber and copper) and drivers would yield the best performance (mostly
> > >transferring large files from server to client, but also latency) in Linux.
> > >I am not a programmer, a kernel tweaker, or a driver developer. I need a
> > >card that either has a driver that comes with Red Hat Linux 7.1 or is easy
> > >to install and needs minimal tweaks to the driver. I am currently
> > >considering cards from 3Com (Alteon), Broadcom, Intel, and SysKonnect.
> > >
> > >Thanks for your help,
> > >
> > >Abe Hayhurst
> > >
> > >-
> > >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > >the body of a message to majordomo@vger.kernel.org
> > >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
