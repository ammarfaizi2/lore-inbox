Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288985AbSA3I3n>; Wed, 30 Jan 2002 03:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSA3I3d>; Wed, 30 Jan 2002 03:29:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40910 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S288579AbSA3I3W>;
	Wed, 30 Jan 2002 03:29:22 -0500
Date: Wed, 30 Jan 2002 03:29:20 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130032920.H32317@havoc.gtf.org>
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com> <8Ho-eVfXw-B@khms.westfalen.de> <20020130034637.J16379@suse.de> <200201300757.g0U7v1t07728@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201300757.g0U7v1t07728@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Jan 30, 2002 at 09:57:02AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:57:02AM -0200, Denis Vlasenko wrote:
> On 30 January 2002 00:46, Dave Jones wrote:
> > On Tue, Jan 29, 2002 at 09:51:00PM +0200, Kai Henningsen wrote:
> >  > >   - cleanliness
> >  > >   - concept
> >  > >   - timing
> >  > >   - testing
> >  >
> >  > IIRC, the number 33 referred to esr's Configure.help patch. Which of
> >  > these did he violate?
> >
> >  Timing.  Linus was busy focusing on the block layer.
> 
> Sounds alarming. Linus didn't take documentation updates from designated 
> maintainer? For many months? I can't believe in argument that updates were 
> able to break _anything_, it's only documentation, right? I could understand 
> this if these updates were sent by little known person, but Eric?!
> 
> Clearly a scalability problem here :-)

Oh-my-lord.  Please re-read this thread, and especially Linus's
2.5.3-pre5 changelog announcement.

Configure.help needed to be split up.  Eric?! was told this repeatedly,
but he did not listen.  Hopefully he will listen to feedback regarding
CML2...  He has even been told repeatedly that he does not
listen to feedback ;-)

	Jeff, chuckling



