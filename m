Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281483AbRLGOFI>; Fri, 7 Dec 2001 09:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281488AbRLGOFC>; Fri, 7 Dec 2001 09:05:02 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:4364 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281483AbRLGOEt>; Fri, 7 Dec 2001 09:04:49 -0500
Subject: Re: kernel: ldt allocation failed
From: James Davies <james_m_davies@yahoo.com>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kiril Vidimce <vkire@pixar.com>,
        Dan Maas <dmaas@dcine.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112071439430.20718-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112071439430.20718-100000@Appserv.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 23:59:55 +1000
Message-Id: <1007733617.2043.0.camel@Lord>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I see my mistake now. While the kernel driver contains source code,
it is only enough to link with the current kernel correctly, and the
rest binary. Sorry.

On Fri, 2001-12-07 at 23:41, Dave Jones wrote:
> On 7 Dec 2001, James Davies wrote:
> 
> > source code IS available for free under a restrictive license. the GLX
> > drivers are closed.
> 
> Bzzzt...
> 
> >From the tarball you posted a link to..
> 
> -rwxr-xr-x    1 davej    users      889615 Nov 27 20:39 Module-nvkernel*
> 
> (davej@noodles:NVIDIA_kernel-1.0-2313)$ file Module-nvkernel
> Module-nvkernel: ELF 32-bit LSB relocatable, Intel 80386, version 1, not
> stripped
> 
> No-one but nvidia knows whats in this.
> 
> regards,
> Dave.
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

