Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271861AbRICXxK>; Mon, 3 Sep 2001 19:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271862AbRICXxB>; Mon, 3 Sep 2001 19:53:01 -0400
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:13200 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271861AbRICXws> convert rfc822-to-8bit; Mon, 3 Sep 2001 19:52:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: machack <machack@sscsonline.org>
Reply-To: machack@sscsonline.org
Organization: SSCS
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
        Thiago Vinhas de Moraes <tvlists@networx.com.br>
Subject: Re: Sound Blaster Live - OSS or Not?
Date: Mon, 3 Sep 2001 19:35:25 -0400
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>, <seawolf-list@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109031555360.24150-100000@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.33.0109031555360.24150-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010903235302.BBPQ27977.femail1.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using the sblive kernel drivers for a year and have not had any 
problems with quake3.  the driver in 2.4.9 works well for me except my mic 
doesn't' want to work. 

On Monday 03 September 2001 07:03 pm, Joel Jaeggli wrote:
> On Mon, 3 Sep 2001, Thiago Vinhas de Moraes wrote:
> > Hi!
> >
> > I have a Sound Blaster Live! PCI that works pretty fine for me.
> >
> > I tried to run loki's Quake 3 Arena for Linux, and after several tries, I
> > started to read the README file, and it said that Sound Blaster Live does
> > not work as OSS. I found a reference to www.opensound.com, where they
> > sell OSS drivers for Sound Blaster Live for $35.00 !! That's too much
> > money for a sound driver! I've downloaded a trial, and it really worked
> > to play Quake.
> >
> > My question is: If the 2.4.9 kernel has support for Sound Blaster Live,
> > why I have to pay for a damn non-GPL driver? Why it does not work to play
> > games on linux?
>
> sound support is hard... The folks at 4-front have the benefit of a
> liscense from the vendor for their intelectual property property used in
> the driver... That has two implications, The code is proprietary, and the
> vendor must be paid... I don't imagine they're getting rich in the
> business but if you have a card that has a chipset that is supported well
> by them and poorly by the various other sound initiatives, you have to
> decide wether it's worth it or not.
>
> In any case your card is fairly well supported by the alsa-project... so
> I'd recomend trying the alsa drivers
>
> > Regards,
> > Thiago
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

