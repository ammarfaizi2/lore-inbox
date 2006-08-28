Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWH1QCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWH1QCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWH1QCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:02:39 -0400
Received: from colin.muc.de ([193.149.48.1]:25358 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751135AbWH1QCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:02:39 -0400
Date: 28 Aug 2006 18:02:37 +0200
Date: Mon, 28 Aug 2006 18:02:37 +0200
From: Andi Kleen <ak@muc.de>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Perkel <marc@perkel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACurrid@nvidia.com, len.brown@intel.com
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060828160237.GA89205@muc.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <200608280924.47968.prakash@punnoor.de> <20060828120540.GA69511@muc.de> <200608281415.41025.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608281415.41025.prakash@punnoor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 02:15:40PM +0200, Prakash Punnoor wrote:
> Am Montag 28 August 2006 14:05 schrieb Andi Kleen:
> > > At least my dmesg says nothing about hpet and thus wan't to enable the
> > > quirk. It is a nforce430 (thus nf4) chipset, though. You can find my
> > > bootlog here:
> >
> > Only NF5 is interesting in this case. On NF4 skipping the timer override
> > is correct.
> 
> Well, then please explain me why it hangs on my nf430 with skipping and works 
> normally w/o skipping?

That's new then. Andy, any explanation?

-Andi
