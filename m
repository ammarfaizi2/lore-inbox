Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUAVVPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUAVVPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:15:14 -0500
Received: from ppp-82-135-4-160.mnet-online.de ([82.135.4.160]:5505 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S265102AbUAVVPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:15:05 -0500
Date: Thu, 22 Jan 2004 22:15:03 +0100
From: Julien Oster <frodoid@frodoid.org>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>
Cc: Julien Oster <frodoid@frodoid.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: parhelia doesn't work anymore with 2.6.1
Message-ID: <20040122211503.GA2147@frodo.midearth.frodoid.org>
References: <Pine.CYG.4.58.0401221751520.3684@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.CYG.4.58.0401221751520.3684@pervalidus>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 05:56:48PM -0200, Frédéric L. W. Meunier wrote:

Hello Frédéric,

> > What about (also) asking for support at
> > http://forum.matrox.com/mga/viewforum.php?f=2 ?

> Nevermind. Sorry. I noticed you've been one of the most helpul
> users - http://forum.matrox.com/mga/viewtopic.php?t=8053

No problem. Thank you :-)

> Yes, too bad Matrox doesn't care much anymore about Linux. I'll
> think twice before buying a Parhelia to replace my G400 since
> it isn't that cheap and the support just suck.

Yes, better think twice. I was using a Matrox G550 before purchasing the
Parhelia. The support was always great, no problems with my G550
whatsoever. So I thought it might be equally as good with the Parhelia,
and the graphics device looked really impressing.

Well, it is impressing, but almost of no use with Linux for me :-(
It works well with 2.4, I'm using it right now with two DVI monitors.
But all the nifty features (I'd really like to have hardware glyph
antialiasing, that's one feature why I bought the card) aren't working
there, either. Not even OpenGL works correctly, and the OpenGL driver is
officially unsupported.

Now, with 2.6, using the card is currently impossible for me. The other
guy on the forum, Prez, who wrote the initial patches for 2.6 says it
works for him. No luck with my NForce2 chipset, though.

I tried making my own patches and first cleaned some things out, but it
didn't help. And with a binary driver you have no chance to get any help
here, not even with the open source parts.

I now at least hope that it won't take too long for Matrox to give out a
driver which works with 2.6 and I think I can give up the hope that
glyph antialiasing will work anytime under Linux.

Better not purchase this card until Matrox has sorted some major things
out. I hope they will.

Regards,
Julien

