Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUITWXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUITWXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUITWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:23:46 -0400
Received: from main.gmane.org ([80.91.229.2]:5326 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267381AbUITWXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:23:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Linux 2.6.9-rc2 (compile stats)
Date: Tue, 21 Sep 2004 00:23:19 +0200
Message-ID: <MPG.1bb976c213d6ed619896f4@news.gmane.org>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org> <1095700064.2867.30.camel@cherrybomb.pdx.osdl.net> <MPG.1bb95958863740f59896f3@news.gmane.org> <Pine.LNX.4.61.0409202244370.2729@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-194-140.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Mon, 20 Sep 2004, Giuseppe Bilotta wrote:
> 
> > Linus Torvalds wrote:
> > > > The one thing that people may actually _notice_ is that you get a lot more 
> > > > warnings for some drivers due to the stricter type-checks for PCI memory 
> > > > mapping. They are harmless (code generation should be the same), and we'll 
> > > > work on trying to fix up the drivers as we go along, but they can be a bit 
> > > > daunting if you happen to enable some of the less type-friendly drivers 
> > > > right now..
> > 
> > John Cherry wrote:
> > > Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
> > >              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> > > -----------  -----------  -------- -------- -------- -------- ---------
> > > 2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
> > > 2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e
> > 
> > Jeepers! Talk about 'daunting' ... :)
> > 
> Yup, janitors like myself just got a whole bunch of work thrown our way...
> 
> Btw, please don't trim CC lists on linux-kernel.

Sorry, I'm using the gmane news/mail bridge, I don't even get 
the CC list :\

(Anyway, it was just a comment of little importance so I hope 
not to have done any damage :))

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

