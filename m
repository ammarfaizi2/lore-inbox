Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbRAROaz>; Thu, 18 Jan 2001 09:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbRAROaq>; Thu, 18 Jan 2001 09:30:46 -0500
Received: from adsl-nrp10-C8B0F87C.sao.terra.com.br ([200.176.248.124]:28915
	"EHLO thor.gds-corp.com") by vger.kernel.org with ESMTP
	id <S130077AbRAROad> convert rfc822-to-8bit; Thu, 18 Jan 2001 09:30:33 -0500
Date: Thu, 18 Jan 2001 12:31:22 -0200 (BRST)
From: Joel Franco Guzmán <joel@gds-corp.com>
To: Josh Myer <josh@joshisanerd.com>
cc: "J . A . Magallon" <jamagallon@able.es>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
In-Reply-To: <20010117043619.B23406@grace>
Message-ID: <Pine.LNX.4.30.0101181227010.1059-100000@thor.gds-corp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Josh Myer wrote:

> You're probably just hearing electrical noise from the memory buss; try
> moving the 128 stick to the slot you put the 64 in (if you can) and run
> that way -- you'll probably hear it there too.

i've exchanged the two memory slot, and the problem is still alive.

>
> I get something similiar to this with my SB Live (!... damn marketroids) on
> a BP6 with 192MB as well. In my case, it's not during DSP use per se, but
> during memory activity. Try dragging a window around in X and listen for
> buzzing.

When i drag a window around in X, the noise don't change. It's a rate
constant and not influencied by the windows movement.

Thank You Josh.

>
> My guess is that JA's console player doesn't move around as much memory as
> the gnome one (imagine that), therefore produces less memory noise.
> --
> /jbm, but you can call me Josh. Really, you can.
>        "car. snow. slippery. wheee.
>         dead josh. car slipped on ice."
>  -- Manda explaining my purchase of kitty litter
>
> On Wed, 17 Jan 2001 17:25:51 J . A . Magallon wrote:
> >
> > On 2001.01.18 Joel Franco Guzmán wrote:
> > > 1. 128M memory OK, but with 192M the sound card generate a noise while
> > > use the DSP.
> > ..
> > > the problem: The sound card generates a toc.. toc.. toc .. toc...while
> > > playing a sound using the DSP of the soundcard. Two "tocs"/sec
> > > aproxiumadetely.
> > >
> > >
> .
> > I have noticed something similar. If I start gqmpeg from the command line
> > in
> > a terminal (rxvt), sounds fine. If I start it from the icon in the gnome
> > panel, it makes that 'toc toc' noise you describe. ????
> > (I know it sounds strange, but real...)
>

-- 
    Joel Franco Guzmán
GDS - Global Dynamic Systems
   joelfranco@bigfoot.com
ICQ 19354050 | (16) 270-6867

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
