Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQKBQUa>; Thu, 2 Nov 2000 11:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131527AbQKBQUU>; Thu, 2 Nov 2000 11:20:20 -0500
Received: from Prins.externet.hu ([212.40.96.161]:57348 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129523AbQKBQUM>; Thu, 2 Nov 2000 11:20:12 -0500
Date: Thu, 2 Nov 2000 17:20:07 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: so vesafb doesn't work in i815
In-Reply-To: <E13rLJT-0001b2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.02.10011021714550.9875-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Alan Cox wrote:

> > It seems that the i815 is not vesa compliant?
> > Cheap!
> 
> The i810 hardware only has limited support for old style linear video modes
> so that is quite possible.
> 

Wow! So then I just cannot use this motherboard at all!
xfree 3.3.6 , also with the driver that can be downloaded from intel - I
could run it only at 320x200x4.
xfree 4.0.1d supports it, but the screen flicker so hard, that is is
unusable. 
Now there is no fb support for it. If they sell a vga card that is not
vesa compliant, they are crazy.

I am angry with intel!
And my bosses, who decided to buy 1500 pcs of this IBM Netvista :-(((

Anyway, I'll have to buy a vga card on my own, if I want to use linux.

2.4.0-test10 seems to be really fine and stable to me!
Thx for your great work guys!

10x4all
Narancs v1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
