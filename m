Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270700AbTGNTQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270712AbTGNTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:16:11 -0400
Received: from viefep14-int.chello.at ([213.46.255.13]:22342 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S270700AbTGNTQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:16:09 -0400
From: Anich Gregor <gregora@web.de>
Reply-To: gregora@web.de
To: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.0-test1 + nvidia 4363 driver
Date: Mon, 14 Jul 2003 21:34:52 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307142134.52068.gregora@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 14 Jul 2003 15:20, Martin Zwickel wrote:
> > Hi there!
> >
> > Anybody got a working patch for nvidia 4363 to let it work with the
> > 2.6.0-test1 kernel?
> > The 2.5 nvidia patch doesn't work for the 2.6 kernel.
> 
> Just a quick hack to the official unofficial patch!  It's working OK for me 
> right now.  You'll need to apply the 2.5 patch then this one afterwards.
> 
> -- 
> 
> Ian.

Hi!

Seems like some people have problems applying your patch.
I have put up a small howto how to compile the NVIDIA_kernel
with linux-2.6 at http://deltaanime.ath.cx/~blight/nvidia_kernel_with_2.6.html
The only thing what breaks it is that the version is no longer below 2, 6, 0 
which the 2.5 patch uses to check wether it's 2.5 or not ;)

hope this helps some poeple,
  Gregor

