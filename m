Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUIFAXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUIFAXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUIFAXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:23:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9122 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267360AbUIFAX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:23:27 -0400
Subject: Re: NVIDIA Driver 1.0-6111 fix
From: Lee Revell <rlrevell@joe-job.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1094426413l.13777l.0l@werewolf.able.es>
References: <200409050203.i8523X6W031952@localhost.localdomain>
	 <1094426413l.13777l.0l@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1094430219.29921.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Sep 2004 20:23:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 19:20, J.A. Magallon wrote:
> On 2004.09.05, Horst von Brand wrote:
> > Lee Revell <rlrevell@joe-job.com> said:
> > > Tim Fairchild <tim@bcs4me.com> said:
> > 
> > [...]
> > 
> > > > Users don't really care about open and closed source. They just want 
> > > > to play quake 3 (etc).
> > 
> > > I have never understood why these people don't just run Windows.
> > 
> > Some run Linux because it _works_, and also want to play.
> > 
> 
> and why do people think that a fast 3d card is only used to play ?
> I'm involved in graphics modelling, 3d simulation, 3d realtime and so on.
> Try to run softimage on top of software GL...
> Or run a lighting simulation of a building on top of the nv+mesa combo.

These users I would expect to use a 3D card with open source drivers,
since correctness is more important than performance in these
situations.

I am more interested in using hw-accelerated 3D for GUIs for audio
apps.  It's by far the cheapest way to update banks of meters, etc.  A 
binary only 3d driver is out of the question, it's hard enough to get it
all to work when you have the source...

Lee   

