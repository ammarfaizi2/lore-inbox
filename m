Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266792AbTGOHaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbTGOHaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:30:09 -0400
Received: from AMarseille-201-1-2-223.w193-253.abo.wanadoo.fr ([193.253.217.223]:47911
	"EHLO gaston") by vger.kernel.org with ESMTP id S266792AbTGOHaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:30:05 -0400
Subject: Re: radeonfb patch for 2.4.22...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: ajoshi@kernel.crashing.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0307141533330.8994@freak.distro.conectiva>
References: <Pine.LNX.4.10.10307141315170.28093-100000@gate.crashing.org>
	 <Pine.LNX.4.55L.0307141533330.8994@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058255052.620.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jul 2003 09:44:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Which is what the original 0.1.8 patch included, his fixes were included.
> 
> Ah really? I though that his changes were not merged in your 0.1.8 patch.
> 
> So can I just revert his patch and accept your instead that all of his
> stuff is in ? Whoaa, great.

No. 0.1.8 lacks a lot of my stuffs

> I prefer playing no silly games in the 2.4 stable series, as I've been
> trying to do so far. If you had accepted Ben's changes in the first place
> I wouldnt need to apply his patch.
> 
> Ben is very interested in maintaining the driver, AFAIK. Is that
> correct, Ben?
> 
> Are you interested in giving up maintenance?
> 
> For me it doenst matter who maintains the driver, as long as it is well
> maintained.

I could take over if Ani wants to give up, though I would prefer a
dedicated maintainer with more time to do the necessary rewrite of
this driver in 2.6 and later, which I don't have time to do right
now, however, I can maintain the existing code base if necessary.

Ben.


