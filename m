Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbQKBQ2L>; Thu, 2 Nov 2000 11:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132215AbQKBQ2C>; Thu, 2 Nov 2000 11:28:02 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:57610
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129932AbQKBQ1w>; Thu, 2 Nov 2000 11:27:52 -0500
Date: Thu, 2 Nov 2000 08:27:21 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Narancs 1 <narancs1@externet.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: so vesafb doesn't work in i815
In-Reply-To: <Pine.LNX.4.02.10011021714550.9875-100000@prins.externet.hu>
Message-ID: <Pine.LNX.4.10.10011020826540.2467-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wait is this like the i810e?

On Thu, 2 Nov 2000, Narancs 1 wrote:

> On Thu, 2 Nov 2000, Alan Cox wrote:
> 
> > > It seems that the i815 is not vesa compliant?
> > > Cheap!
> > 
> > The i810 hardware only has limited support for old style linear video modes
> > so that is quite possible.
> > 
> 
> Wow! So then I just cannot use this motherboard at all!
> xfree 3.3.6 , also with the driver that can be downloaded from intel - I
> could run it only at 320x200x4.
> xfree 4.0.1d supports it, but the screen flicker so hard, that is is
> unusable. 
> Now there is no fb support for it. If they sell a vga card that is not
> vesa compliant, they are crazy.
> 
> I am angry with intel!
> And my bosses, who decided to buy 1500 pcs of this IBM Netvista :-(((
> 
> Anyway, I'll have to buy a vga card on my own, if I want to use linux.
> 
> 2.4.0-test10 seems to be really fine and stable to me!
> Thx for your great work guys!
> 
> 10x4all
> Narancs v1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
