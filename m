Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314676AbSEBRZ7>; Thu, 2 May 2002 13:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314679AbSEBRZ6>; Thu, 2 May 2002 13:25:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32881 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314676AbSEBRZ4>; Thu, 2 May 2002 13:25:56 -0400
Date: Thu, 2 May 2002 13:25:52 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020502132552.G8073@devserv.devel.redhat.com>
In-Reply-To: <E173HX6-00041D-00@the-village.bc.nu> <3CD13FF3.5020406@evision-ventures.com> <3CD15996.8EB1699F@redhat.com> <200205021559.g42Fxud19755@vindaloo.ras.ucalgary.ca> <3CD15CFA.1090208@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 05:36:26PM +0200, Martin Dalecki wrote:
> U¿ytkownik Richard Gooch napisa³:
> > Arjan van de Ven writes:
> > 
> >>someone using perl to replace the built-in kernel version in the .o
> >>file)
> > 
> > 
> > Oh, my! Do people really do that?!?
> 
> Yes they do, if they wont for example to get some
> PCTEL win chip driver working. No matter what Alan and some others
> think is good for them :-).
> 
> The main problem with mod-versions is the simple fact
> that policy doesn't belong in to the kernel it belongs
> in the user space. And mod-version is *just policy*.
> 
> See... if some impaired project manager at some
> linux distro provider associated with hats,
> who does decisions like for example basing the main OS
> configuration tools on instable programming languages
> like python or perl... does decide that he needs
> the functionality of MODULEVERSIONS to get full controll about the
> users of his crappy product. Why the hell doesn't he let all this
> version checking be done for his own kernel cook-up entierly in
> his patched mod-utils? And entierly in USER SPACE? He does
> have the full scope of things which need the bless of versioning
> over them at his hands and there is *no technical* argument why this
> should be done in kernel space at all!


Thank you for this insult and welcome to my .procmailrc

Oh and please don't forget your medicine tomorrow as you did today..

 
> It just DOES NOT BELONG in to the kernel-space.

That's why it's done by modutils.

