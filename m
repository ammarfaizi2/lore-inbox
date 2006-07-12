Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWGLQyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWGLQyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWGLQyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:54:44 -0400
Received: from ns.suse.de ([195.135.220.2]:32713 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751461AbWGLQyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:54:43 -0400
Date: Wed, 12 Jul 2006 18:54:23 +0200
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, klibc@zytor.com,
       Jeff Garzik <jeff@garzik.org>, Roman Zippel <zippel@linux-m68k.org>,
       Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060712165423.GA25071@suse.de>
References: <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com> <20060711181552.GD16869@suse.de> <44B3EC5A.1010100@zytor.com> <20060711200640.GA17653@suse.de> <20060711212232.GA32698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060711212232.GA32698@kroah.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, Greg KH wrote:

> On Tue, Jul 11, 2006 at 10:06:40PM +0200, Olaf Hering wrote:
> > And to give a negative example for great regression test opportunities:
> > You guessed it, SLES10 has a udev that cant handle kernels before 2.6.15.
> > Great job. I could slap them all day...
> 
> Just to be specific, the udev in SLES10 can handle older kernels than
> 2.6.15 just fine, it's just the boot scripts around it are not written
> to do so.

What difference does that make exactly? "It doesnt work."
