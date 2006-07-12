Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWGLRBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWGLRBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWGLRBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:01:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:10683 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751463AbWGLRBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:01:45 -0400
Date: Wed, 12 Jul 2006 19:01:27 +0200
From: Olaf Hering <olh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>,
       klibc@zytor.com, Jeff Garzik <jeff@garzik.org>,
       Roman Zippel <zippel@linux-m68k.org>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060712170127.GA25277@suse.de>
References: <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com> <20060711181552.GD16869@suse.de> <44B3EC5A.1010100@zytor.com> <20060711200640.GA17653@suse.de> <20060711212232.GA32698@kroah.com> <20060712165423.GA25071@suse.de> <1152723518.3217.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1152723518.3217.53.camel@laptopd505.fenrus.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jul 12, Arjan van de Ven wrote:

> On Wed, 2006-07-12 at 18:54 +0200, Olaf Hering wrote:
> >  On Tue, Jul 11, Greg KH wrote:
> > 
> > > On Tue, Jul 11, 2006 at 10:06:40PM +0200, Olaf Hering wrote:
> > > > And to give a negative example for great regression test opportunities:
> > > > You guessed it, SLES10 has a udev that cant handle kernels before 2.6.15.
> > > > Great job. I could slap them all day...
> > > 
> > > Just to be specific, the udev in SLES10 can handle older kernels than
> > > 2.6.15 just fine, it's just the boot scripts around it are not written
> > > to do so.
> > 
> > What difference does that make exactly? "It doesnt work."
> > -
> 
> who cares?

I do damnit. Its just a udevstart away...
Anyway, offtopic.
