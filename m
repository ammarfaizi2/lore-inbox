Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318392AbSGYKON>; Thu, 25 Jul 2002 06:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318393AbSGYKON>; Thu, 25 Jul 2002 06:14:13 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:65458 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S318392AbSGYKON>;
	Thu, 25 Jul 2002 06:14:13 -0400
To: Dave Jones <davej@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
	<20020725011517.P16446@suse.de>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 25 Jul 2002 12:16:37 +0200
In-Reply-To: <20020725011517.P16446@suse.de>
Message-ID: <m3znwgdse2.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:

> On Wed, Jul 24, 2002 at 02:13:49PM -0700, Linus Torvalds wrote:
>  
>  > ... Serial lawyer all shook up (the irq lock kind of forced that one,
>               ^^^^^^^
>  > but it's certainly been  pending long enough..)
> 
> Shake `em harder, lets see what falls out. 8-)
> 

Run the serial port too fast and it won't crash... it'll sue you,
american style :)

>         Dave.
> 

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
