Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286318AbRLJRKh>; Mon, 10 Dec 2001 12:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286320AbRLJRK3>; Mon, 10 Dec 2001 12:10:29 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36615 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286318AbRLJRKT>; Mon, 10 Dec 2001 12:10:19 -0500
Date: Mon, 10 Dec 2001 13:53:50 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patches in 2.4.17-pre2 that aren't in 2.5.1-pre8
In-Reply-To: <3C149FF9.407@epfl.ch>
Message-ID: <Pine.LNX.4.21.0112101348470.25093-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nicolas, 

Who is the maintainer of the driver ?

Try to think from my side: I may have no hardware or time to test all
patches which come to me.

Please, people, send this kind of driver changes to the people who know
all hardware specific details.

If there is no maintainer for i810, I'll be glad to apply it on 2.4.18pre
and wait for reports. Not going to be on 2.4.17, though.

On Mon, 10 Dec 2001, Nicolas Aspert wrote:

> Hello all
> 
> 
> 
> > 
> > In many cases that isnt true, and for a lot of the pending patches its
> > pointless merging them into 2.5 until 2.5 gets into better shape. Going back
> > over them as you have done is something that does need doing, but not until
> > the block layer has some semblance of completion about it
> 
> Well I just saw the opposite ;-) ... A patch I had submitted a few weeks 
> ago for Intel 830MP agp support has been intgrated in 2.5.1-pre3, but is 
> still not in the 2.4 branch... Several users have reported success with 
> this patch, so unless somebody shows storng opposition, I would suggest 
> to merge it...
> Get it here : http://ltswww.epfl.ch/~aspert/patches/patch-agp_i830mp-2.4.16
> 
> Best regards
> -- 
> Nicolas Aspert      Signal Processing Laboratory (LTS)
> Swiss Federal Institute of Technology (EPFL)
> 

