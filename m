Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSDMWIK>; Sat, 13 Apr 2002 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSDMWIJ>; Sat, 13 Apr 2002 18:08:09 -0400
Received: from jalon.able.es ([212.97.163.2]:35548 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S310769AbSDMWIJ>;
	Sat, 13 Apr 2002 18:08:09 -0400
Date: Sun, 14 Apr 2002 00:08:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020413220800.GA4283@werewolf.able.es>
In-Reply-To: <E16wSh5-0000ue-00@the-village.bc.nu> <3CB88713.4070209@zytor.com> <200204131937.g3DJbw607029@vindaloo.ras.ucalgary.ca> <3CB889C7.2080907@zytor.com> <200204131949.g3DJnhD07302@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.13 Richard Gooch wrote:
>H. Peter Anvin writes:
>> Richard Gooch wrote:
>> > 
>> > Actually, there is some impedance matching. I've seen monitors with
>> > hi/lo impedance switches. And I've used 15 m long high-quality VGA
>> > cables. The result has been pretty good.
>> > 
>> 
>> The best I've seen is to use Sun D-sub coax or plain coax inputs on
>> the monitors that have them.  Those are impedance matched and can be
>> extended without problem.
>
>Sure, coax inputs are the best. But there are still problems. Even
>expensive coax has higher attenuation at higher frequencies, so the
>longer the cable, the more fuzziness you get. Also, there are
>differential delay effects between the R, G and B components. You
>don't want the pixel components to arrive at different times. So
>there's a length limitation there as well.
>
>But even though coax is better, VGA isn't that bad. 15 m gets you
>quite a lot of terminals in a web kiosk (or undergrad computer lab).
>
>BTW: I agree that X terminals suck. Even worse are SunRays. Ug!
>

We have built a 'pseudo-CAVE' for presentations, and have six vgas
feeding sony projectors with cabling between 15 and 20m, running
at 1024x768@32. Quality is ok.

The problem is finding good PCI vga cards, even finding any,
good or bad. Now they are TNT-M64. I'm also aware that SiS has some,
but nothing special. But, to use it as terminals, they could be ok.

And coax is not so good. Even with expensive cable, the bounces of
the signal made me see double like drunk. Video did not worked right
until we got _golden_ connectors and soldered with silver. Believe
me you could even put more mony on the cables that on the box.

Physics is funny...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre6-jam1 #1 SMP Sun Apr 7 00:50:05 CEST 2002 i686
