Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSCCQ0i>; Sun, 3 Mar 2002 11:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSCCQ03>; Sun, 3 Mar 2002 11:26:29 -0500
Received: from c9mailgw.prontomail.com ([216.163.188.206]:19984 "EHLO
	C9Mailgw03.amadis.com") by vger.kernel.org with ESMTP
	id <S285720AbSCCQ0N>; Sun, 3 Mar 2002 11:26:13 -0500
Message-ID: <3C824E68.13EE719@starband.net>
Date: Sun, 03 Mar 2002 11:25:12 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Ricketts <mike@earth.li>
CC: janvapan <jvp@wanadoo.es>, linux-kernel@vger.kernel.org
Subject: Re: Recommendations about a 100/10 NIC
In-Reply-To: <Pine.LNX.4.10.10203031559090.801-100000@oakley.chf>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting, I get 11.6MB/s peaks with multiple 100mbits.
3COM's have been great here.
I have 4-5 100mbit 3COM NICS (905bs) (PCI).
And about 10-20 10mbits (ISA+PCI).
All have worked great!
Usually when people have problems with 10/100mbit, they have a half duplex hub or
something lol.

As far as speed is concerned:
Half Duplex hub = Worst
Full Duplex hub = Better
100mbit full duplex switch = best

Mike Ricketts wrote:

> Interesting - I'd say definitely *NOT* the 3com.  I've had a lot of bad
> experience with all sorts of 3com cards when trying to use them at
> 100MBit.  At 10, they are fine, but shove them up to 100 and anything can
> and sometimes does happen.  I have a number of intel cards and have never
> had any problem at all with any of them.
>
> On Sun, 3 Mar 2002, Justin Piszcz wrote:
>
> > I'd reccomend a 3COM, as they come with a lifetime warranty and have always
> > been good for me.
> > Not sure about Intels.
> > I have a 3com 905b, the current model is a 3com 905C-TX like you mentioned.
> >
> > janvapan wrote:
> >
> > > What ethernet cards I should use for Linux 2.4?.
> > > I am looking for a NIC based on stability and performance.
> > > In short, Intel PRO/100 S Desktop Adapter(e100 driver) or
> > > 3Com 10/100 3C905C-TX-M(3c59x driver) ?
> > >
> > > thank you,
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> Mike Ricketts <mike@earth.li>                      http://www.earth.li/~mike/
>
> You work very hard.  Don't try to think as well.

