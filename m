Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbRGKCCu>; Tue, 10 Jul 2001 22:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbRGKCCk>; Tue, 10 Jul 2001 22:02:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30594 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267182AbRGKCCZ>;
	Tue, 10 Jul 2001 22:02:25 -0400
Message-ID: <3B4BB3B0.F6FB3443@mandrakesoft.com>
Date: Tue, 10 Jul 2001 22:02:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
Cc: daniel sheltraw <l5gibson@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: CardBus and PCI
In-Reply-To: <F34guA8M6XQQez1enAq000153a1@hotmail.com> <3B4B6DB8.F26663A1@mandrakesoft.com> <20010710213830.A13597@animx.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> > > If a CardBus card is in a slot at boot time is it treated as PCI device
> > > would be? Is it just another device on another PCI bus?
> >
> > In kernel 2.4 and using kernel cardbus support, yes.
> 
> But is it possible for it to be configured at boot time (like to use it for
> nfsroot)

In kernel 2.4 and using kernel cardbus support, yes.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
