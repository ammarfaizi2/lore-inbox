Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293505AbSBZEPu>; Mon, 25 Feb 2002 23:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293506AbSBZEPk>; Mon, 25 Feb 2002 23:15:40 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:6790 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293505AbSBZEPa>;
	Mon, 25 Feb 2002 23:15:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Subject: Re: Linux 2.4.18
Date: Sun, 24 Feb 2002 06:08:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16equ1-0001QS-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 25, 2002 08:18 pm, Marcelo Tosatti wrote:
> On Mon, 25 Feb 2002, Holzrichter, Bruce wrote:
> > > Ok, DAMN. I missed the -rc4 patch in 2.4.18. Real sorry about that.
> > > 
> > > 2.4.19-pre1 will contain it. 
> > 
> > Should 2.4.18 final get a -dontuse tag or something?  
> 
> No. A "-dontuse" tag should be only used when the kernel can cause damage
> in some way.

That reminds me, why did 2.4.15 never get a -dontuse?  Did the iput bugfix
get quietly added, or is it still an accident waiting to happen?

I think there'a a limit to how strict one should be about the 'don't change
it after posting rule'.

-- 
Daniel
