Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266251AbRHMTH4>; Mon, 13 Aug 2001 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbRHMTHr>; Mon, 13 Aug 2001 15:07:47 -0400
Received: from mail.nep.net ([12.23.44.24]:36626 "HELO nep.net")
	by vger.kernel.org with SMTP id <S266251AbRHMTHf>;
	Mon, 13 Aug 2001 15:07:35 -0400
Message-ID: <19AB8F9FA07FB0409732402B4817D75A038A60@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: "Daniel T. Chen" <crimsun@email.unc.edu>,
        "Ryan C. Bonham" <Ryan@srfarms.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Date: Mon, 13 Aug 2001 15:11:54 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, that true.. I could, and will if necessary.. But my point was, which I
didn't make that well,  wouldn't it make more sense to leave the new driver
in the AC builds, and test it there, especially if Alan doesn't like it in
Linus's 2.4.X tree.   Maybe not, I don't know.. 

> -----Original Message-----
> From: Daniel T. Chen [mailto:crimsun@email.unc.edu]
> Sent: Monday, August 13, 2001 2:58 PM
> To: Ryan C. Bonham
> Cc: Linus Torvalds; Alan Cox; linux-kernel@vger.kernel.org
> Subject: RE: Hang problem on Tyan K7 Thunder resolved -- SB Live!
> heads-up
> 
> 
> Or... you could use Alan's -ac patches with CVS checkouts from
> opensource.creative.com, the "best of all 2.4 with sblive
> worlds." ;) Coincidentally, this appeared earlier today:
> -- snip --
> Module name:    emu10k1
> Changes by:     rsousa  01/08/13 07:42:32
> 
> Modified files:
>         .              : audio.c 
> 
> Log message:
> Corrected tasklet cleanup.
> -- snip --
> 
> ---
> Dan Chen                 crimsun@email.unc.edu
> GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc
> 
> On Mon, 13 Aug 2001, Ryan C. Bonham wrote:
> 
> > So my basic question is; Alan, can you leave the new sound 
> driver in your AC
> > kernels? Your kernels are great, and I would love to run 
> them with the new
> > driver, even if it means I have to find some problems... 
> 
> 
