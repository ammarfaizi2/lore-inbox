Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270689AbRHJXZb>; Fri, 10 Aug 2001 19:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270684AbRHJXZW>; Fri, 10 Aug 2001 19:25:22 -0400
Received: from zero.tech9.net ([209.61.188.187]:23304 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S270683AbRHJXZP>;
	Fri, 10 Aug 2001 19:25:15 -0400
Subject: Re: [PATCH] 2.4.7-ac11: Updated emu10k1 driver
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15VLWl-0001qB-00@the-village.bc.nu>
In-Reply-To: <E15VLWl-0001qB-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 10 Aug 2001 19:26:15 -0400
Message-Id: <997485978.898.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Aug 2001 00:17:15 +0100, Alan Cox wrote:
> > Alan, please consider merging this.  I know it is big but how else will
> > we ever get it back in sync?  I will work to keep it up to date if it
> > falls behind again.
> 
> Is there ar reason the maintainer hasnt submitted it yet ?

The "maintainer" is listed as Creative.  They have not updated anything
in a year (in the kernel tree; their CVS tree gets frequent updates).
There was a thread a month or so ago where the emu10k1 was mentioned and
the reply was "get the updated driver" -- I asked why the kernel driver
was so old and I was told a patch was floating around but it had not
been merged.  I have never seen this patch, so I replied I would do it
myself.

It took awhile but here it is.

I don't think there is a reason as in "its beta code" or "it needs to
remain a module for licensing reasons" -- its solid (admittedly better
than what is in there now, has more features, and is GLPed).

With the exception of the two modifications listed, its right from the
Creative CVS tree.  It compiles.  It works for me.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

