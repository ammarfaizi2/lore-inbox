Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTFYVGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTFYVGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:06:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16616 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265062AbTFYVGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:06:03 -0400
Date: Wed, 25 Jun 2003 23:20:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roland Mas <roland.mas@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
Message-ID: <20030625212007.GV3710@fs.tum.de>
References: <1056493150.2840.17.camel@ori.thedillows.org> <20030624204828.I30001@newbox.localdomain> <87vfuuvc0h.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vfuuvc0h.fsf@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 09:42:38AM +0200, Roland Mas wrote:
> Scott McDermott, 2003-06-24 20:48:28 -0400 :
> 
> > There were recent threads about this, and a Bugzilla bug 829 I
> > think.  Try killing magicdev.
> 
> Okay, I'll ask a LKML-newbie question.  Bugzilla says "Linux 2.5
> kernel bugs only at this time"...  Does that mean this bug won't be
> fixed in 2.4, or just that the fix will be written for 2.5 and then
> backported to 2.4?

The Bugzilla tracks only 2.5 bugs.

Whether it will be fixed in 2.4 or a fix will be backported to 2.4 is 
beyond the scope of the Bugzilla (but of course Bugzilla does not 
affect how kernel developers write and submit fixes).

> Roland.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

