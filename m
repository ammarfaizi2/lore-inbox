Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSL0Ch3>; Thu, 26 Dec 2002 21:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbSL0Ch3>; Thu, 26 Dec 2002 21:37:29 -0500
Received: from p008.as-l031.contactel.cz ([212.65.234.200]:28288 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S264745AbSL0Ch2>;
	Thu, 26 Dec 2002 21:37:28 -0500
Date: Fri, 27 Dec 2002 03:44:17 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Paulo Andre'" <fscked@netvisao.pt>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: also frustrated with the framebuffer and your matrox-card in 2.5.53? hack/patch available!
Message-ID: <20021227024417.GD1412@ppc.vc.cvut.cz>
References: <20021226142032.GA7852@middle.of.nowhere> <20021226191510.63802d2d.fscked@netvisao.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021226191510.63802d2d.fscked@netvisao.pt>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 07:15:10PM +0000, Paulo Andre' wrote:
> On Thu, 26 Dec 2002 15:20:32 +0100
> Jurriaan <thunder7@xs4all.nl> wrote:
> 
> > This is a patch to downgrade the framebuffer files in linux-2.5.53 back
> > to 2.5.50, where the matrox-framebuffer worked perfectly.
> 
> Would be nice if the radeonfb worked too. Is this driver ever going to be fixed
> in 2.5?

With Jurriaan's hack ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/radeon.tgz
should work - it is 2.4.18 version of driver ported to 2.5.50. Only thing I can
say about it is that it works on my Compaq notebook in 1600x1200, with 
2.5.51-bkSomething.

I did not talked to Ani Joshi about it yet, as it does not work in latest 2.5.x
kernels, so as is patch is of no use for anyone using 2.5.52+.
							Petr Vandrovec
							vandrove@vc.cvut.cz
