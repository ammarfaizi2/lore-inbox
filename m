Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262737AbRE3LZt>; Wed, 30 May 2001 07:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262738AbRE3LZj>; Wed, 30 May 2001 07:25:39 -0400
Received: from [203.143.19.4] ([203.143.19.4]:63506 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262737AbRE3LZY>;
	Wed, 30 May 2001 07:25:24 -0400
Date: Wed, 30 May 2001 17:23:25 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Robert Siemer <siemer@panorama.hadiko.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler warning fix in aci.c
In-Reply-To: <20010530113700W.siemer@panorama.hadiko.de>
Message-ID: <Pine.LNX.4.21.0105301718480.22876-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001, Robert Siemer wrote:

> From: Anuradha Ratnaweera <anuradha@gnu.org>
>
> > On Wed, 30 May 2001, Anuradha Ratnaweera wrote:
> > 
> > > Following patch fixes a compiler warning in aci.c.
> > 
> > I can guess the usefullness of the functiion print_bits that would be
> > removed if my patch is applied. If this is so, how about putting it
> > inside an "#ifdef DEBUG"?
> 
> This is exactly what I did some month ago with my little working tree.

So will you be adding the "#ifdef" again?
 
> Anyway: are you using some aci-supported hardware? Which one?

No. I just compiled a kernel with a generic .config and noticed the
compiler warning.

Regards,

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/

