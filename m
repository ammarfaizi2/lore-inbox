Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSFKRH6>; Tue, 11 Jun 2002 13:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSFKRH5>; Tue, 11 Jun 2002 13:07:57 -0400
Received: from bgp401130bgs.jersyc01.nj.comcast.net ([68.36.96.125]:3090 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S317191AbSFKRH5>;
	Tue, 11 Jun 2002 13:07:57 -0400
Date: Tue, 11 Jun 2002 13:07:52 -0400
Message-Id: <200206111707.g5BH7qA10658@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANN: Linux 2.2 driver compatibility toolkit
In-Reply-To: <3D051CC2.1030301@mandrakesoft.com>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002 17:40:18 -0400, Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> 
> Don't load your drivers up with 2.2.x compatibility junk.  Write a 2.4.x 
> driver... and use this toolkit to make it work under 2.2.

Now, if you could get Alan to include it in 2.2.next, that would be even
better. I could probably drop 90% of the cruft I have in starfire-kcomp22.h...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
