Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132590AbRDOH0S>; Sun, 15 Apr 2001 03:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132589AbRDOHZ6>; Sun, 15 Apr 2001 03:25:58 -0400
Received: from mail1.rdc2.ab.home.com ([24.64.2.48]:49074 "EHLO
	mail1.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S132587AbRDOHZv>; Sun, 15 Apr 2001 03:25:51 -0400
Message-ID: <3ADA4D72.4995726@home.com>
Date: Sun, 15 Apr 2001 19:40:02 -0600
From: "Matthew W. Lowe" <swds.mlowe@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 - Module problems?
In-Reply-To: <3ADA49F0.A412EAA@home.com> <3AD94B19.C73357A1@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> "Matthew W. Lowe" wrote:
> > I just tried to upgrade from whatever kernel comes with redhat to 2.4.3.
> > The build, install and such was smooth. When I got to starting up,
> > everything appeared to work, until it got to my NIC cards. Neither of
> > them loaded properly. I've built in the EXACT same module for the NICs
> > as I did the previous kernel. They were the NE2000 PCI module and the
> > 3C59X module. The two NICs I have are: Realtek 8029 PCI, 3COM Etherlink
> > III ISA. Both are PNP, the etherlink is NOT the one with the b extention
> > at the end.
>
> Maybe this is a typo or maybe not -- "3c509" is for Etherlink III ISA,
> "3c59x" is for recent 3com PCI/EISA busmastering 10/100 NICs.

Errr, yea you're right it was a typo ** hits head **. I was thinking about my
friends problem with his install of linux at the time of writing, he has the
3c59x.

>
>
> --
> Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
> Building 1024     |  man to fish, and a US Navy submarine will make sure
> MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

