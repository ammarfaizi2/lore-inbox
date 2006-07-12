Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWGLVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWGLVkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWGLVkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:40:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:3802 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751425AbWGLVkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:40:46 -0400
Date: Wed, 12 Jul 2006 14:36:08 -0700
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, klibc@zytor.com,
       Jeff Garzik <jeff@garzik.org>, Roman Zippel <zippel@linux-m68k.org>,
       Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060712213608.GA9049@kroah.com>
References: <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com> <20060711181552.GD16869@suse.de> <44B3EC5A.1010100@zytor.com> <20060711200640.GA17653@suse.de> <20060711212232.GA32698@kroah.com> <20060712165423.GA25071@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712165423.GA25071@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 06:54:23PM +0200, Olaf Hering wrote:
>  On Tue, Jul 11, Greg KH wrote:
> 
> > On Tue, Jul 11, 2006 at 10:06:40PM +0200, Olaf Hering wrote:
> > > And to give a negative example for great regression test opportunities:
> > > You guessed it, SLES10 has a udev that cant handle kernels before 2.6.15.
> > > Great job. I could slap them all day...
> > 
> > Just to be specific, the udev in SLES10 can handle older kernels than
> > 2.6.15 just fine, it's just the boot scripts around it are not written
> > to do so.
> 
> What difference does that make exactly? "It doesnt work."

Then say "the boot scripts are causing older kernels not to work", not
"udev can't handle kernels before 2.6.15", which is not true.

pedantically,

greg k-h
