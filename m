Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292419AbSBUPJd>; Thu, 21 Feb 2002 10:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292374AbSBUPJP>; Thu, 21 Feb 2002 10:09:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34566 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292419AbSBUPJB>;
	Thu, 21 Feb 2002 10:09:01 -0500
Message-ID: <3C750D8A.435317E4@mandrakesoft.com>
Date: Thu, 21 Feb 2002 10:08:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Lang <david.lang@digitalinsight.com>, andersen@codepoet.org,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <E16duzn-0007E0-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > 2. does it handle the 'I want this feature, turn on everything I need for
> > > it'?
> >
> > This is fundamentally impossible for anything beyond the most simple
> > features. Although you can do a lot with config.in info, "everything I
> > need" is something a human needs to define in many cases.
> 
> You can do that with CML1 or his code. The problem is that you need to
> go back through checking with the user because

I think I am stumbling over semantics... I know you can turn on needed
stuff when you say "I want CONFIG_USB_HID",
but "I want this feature, turn on everything I need" sounded to me more
like autoconfigurator-type stuff, which is guessing at best.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
