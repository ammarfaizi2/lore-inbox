Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317747AbSFNIz5>; Fri, 14 Jun 2002 04:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSFNIz4>; Fri, 14 Jun 2002 04:55:56 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:40064 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317747AbSFNIz4>;
	Fri, 14 Jun 2002 04:55:56 -0400
Date: Fri, 14 Jun 2002 10:55:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
Message-ID: <20020614105553.A444@ucw.cz>
In-Reply-To: <20020614103746.A324@ucw.cz> <Pine.LNX.4.10.10206140140040.21513-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 01:45:20AM -0700, Andre Hedrick wrote:

> On Fri, 14 Jun 2002, Vojtech Pavlik wrote:
> > On Fri, Jun 14, 2002 at 01:20:34AM -0700, Andre Hedrick wrote:

> > > Read about the JUNK hardware base you are working with.
> > > This is one of the reasons people avoid VIA.

> > Hmm, I don't want to interfere in this nicely-growing flamethrowing, but
> > Andre, you might have noticed, that Nick is saying that it actually
> > *works* on the VIA controller and doesn't on the Promise one. Plus older
> > kernels do work on the Promise controller. That's clearly a software
> > problem.

> Well if you have not read, I offered to export the changes to the kernel
> he states works as a way to isolate the driver from other changes.
> We have Promise adding their two cents, also.

Yes, but only after you sent him to hell for "user error".

> How about you rewriting the driver an take my name out of it too.

Not such a bad idea after all. But the Promise hardware has way too many
quirks only the Promise people know for my tastes, even more than VIA.
And, after all, as far as I know Bartek is rewriting it right now.  ;)

> Then you can have all the credit be yours.

And all blame and responsibility - which, I think should make you quite
happy. Also note that you're still credited in the rewritten drivers. 

-- 
Vojtech Pavlik
SuSE Labs
