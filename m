Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293164AbSCJTKy>; Sun, 10 Mar 2002 14:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSCJTKo>; Sun, 10 Mar 2002 14:10:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20234 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293164AbSCJTKc>;
	Sun, 10 Mar 2002 14:10:32 -0500
Message-ID: <3C8BAFAE.56CE16E9@mandrakesoft.com>
Date: Sun, 10 Mar 2002 14:10:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: Stephan von Krawczynski <skraw@ithnet.com>, J Sloan <joe@tmsusa.com>,
        linux-kernel@vger.kernel.org, elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <E16bhwo-0007GZ-00@bronto.zrz.TU-Berlin.DE> <3C6D1E99.6070303@tmsusa.com> <20020227151218.78965262.skraw@ithnet.com> <20020310163339.H16784@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> 
> On Wed, Feb 27, 2002 at 03:12:18PM +0100, Stephan von Krawczynski wrote:
> > Hello,
> >
> > quick additional question concerning this topic:
> > If I were free to buy any Gigabit Adapter, what would be the known-to-work
> > choice (including existence of a GPL driver, of course)?
> 
> >From my point of view, there is no 'perfect' choice.
> 
> You can buy bcm57xx based boards, where the chipset is nice but the driver
> not really nice yet.

What's not nice about "tg3"?

Have you tested it, and have bugs to report?

-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
