Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUGLQzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUGLQzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUGLQzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:55:37 -0400
Received: from main.gmane.org ([80.91.224.249]:43453 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266887AbUGLQzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:55:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: VESA fb problem with 2.6.7-mm[567]
Date: Mon, 12 Jul 2004 18:55:02 +0200
Message-ID: <MPG.1b5cdffbb30a3cf69896d4@news.gmane.org>
References: <20040711203659.GE2899@charite.de> <Pine.LNX.4.58.0407112245580.8681@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> On Sun, 11 Jul 2004, Ralf Hildebrandt wrote:
> 
> > The nvidia graphics card in one of my laptops cannot be talked into
> > working with vesafb:
> 
> Maybe try vesafb-tng at http://dev.gentoo.org/~spock/ .
> This is completly rewritten, better and more correct implementation with 
> maany new features. See docs.
> 
> It is working for me with nvidia binary drivers for X and vesafb-tng for 
> console.

vesafb-tng doesn't work with my GeForce2 Go on an Inspiron 8200 
if I set it to use maximu resolution (1600x1200). The screen 
gets all messed up, as if the video mode wasn't set to match 
the use of the framebuffer.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

