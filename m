Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263635AbRFARon>; Fri, 1 Jun 2001 13:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263638AbRFARod>; Fri, 1 Jun 2001 13:44:33 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11936 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263635AbRFARoT>;
	Fri, 1 Jun 2001 13:44:19 -0400
Message-ID: <3B17D471.D636E208@mandrakesoft.com>
Date: Fri, 01 Jun 2001 13:44:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 still breaks dhcpcd with 8139too
In-Reply-To: <20010529215647.A3955@greenhydrant.com> <3B147F80.31EC7520@mandrakesoft.com> <20010531104437.C10057@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> 
> On Wed, 30 May 2001, Jeff Garzik wrote:
> 
> > > I see that Alan has reverted back to the 2.4.3 driver for his ac-series for
> > > other reasons, hopefully either the old driver will going in to 2.4.6 or the
> > > new one will get fixed?
> >
> > I've got one of the two problems fixed here at the test lab, and am
> > working on the second.  Hopefully this week I'll have this sorted out,
> > and a driver for you guys to test.
> 
> Will that 8139too be able to share its IRQ with a bttv card (Hauppauge
> WinTV in my case)? With 2.2.19, it's currently possible, at least after
> unloading and reloading the 8139too module, but it's a no-go with 2.4.5.

Can you be more explicit than "no-go"?  8139too should share interrupts
just fine.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
