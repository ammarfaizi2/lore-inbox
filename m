Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290809AbSCAUAU>; Fri, 1 Mar 2002 15:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293695AbSCAT6l>; Fri, 1 Mar 2002 14:58:41 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:44548 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S293681AbSCAT6T> convert rfc822-to-8bit;
	Fri, 1 Mar 2002 14:58:19 -0500
Date: Fri, 1 Mar 2002 21:58:17 +0200 (EET)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: Blue Lang <blue@b-side.org>
cc: Thomas Schenk <tschenk@origin.ea.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Recommendations on Gigabit Ethernet Cards
In-Reply-To: <Pine.LNX.4.30.0203011418140.10809-100000@gib.soccerchix.org>
Message-ID: <Pine.LNX.4.33.0203012155550.10668-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Mar 2002, Blue Lang wrote:

> On 1 Mar 2002, Thomas Schenk wrote:
>
> > I am looking for recommendations on which of the gigabit ethernet cards
> > supported by the 2.4.x (x >= 17) kernel I should use.  Any guidance
> > based on personal experience would be greatly appreciated.  I am looking
> > for recommendation based on performance and stability of the driver.
>
> i've had decent results (excellent performance, occasional light glitches)
> with the broadcom 1000bt copper ethernet cards, in both server and
> workstation use. the only problems i've had with them are related to
> trying to use them with fixed-speed ports attached to cisco switches. if
> you put em all in a rack with a nice GB switch, they kick butt.
>

These cards are now supported by the new Tigon3-driver. URL and more
information about the driver can be found from mail with subject:

"Subject: [BETA-0.93] Fourth test release of Tigon3 driver"

You can find broadcom5700-chipset at least from 3com 3c996 cards.


Intel's EtherExpress Pro/1000 cards do also have new driver in the
kernel..


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

