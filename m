Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270719AbRHKElT>; Sat, 11 Aug 2001 00:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270718AbRHKElK>; Sat, 11 Aug 2001 00:41:10 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:45316 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S270717AbRHKElC>; Sat, 11 Aug 2001 00:41:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VM nuisance
Date: Sat, 11 Aug 2001 00:41:12 -0400
X-Mailer: KMail [version 1.3]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108110117160.3530-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108110117160.3530-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010811044103Z270717-760+22@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 August 2001 00:17, Rik van Riel wrote:
> On 10 Aug 2001, H. Peter Anvin wrote:
> > > I haven't got the faintest idea how to come up with an OOM
> > > killer which does the right thing for everybody.
> >
> > Basically because there is no such thing?
>
> Actually the killer itself isn't the problem.
>
> It's deciding when to let it kick in.

I was under the presumption from what David and others have said that the OOM 
sometimes works the way it was meant to and kills the offending program, or 
it put the box into this super sluggish state for a very long time regardless 
if it was early or late.   If it only happens when it's late then what was 
David talking about?   



> Rik
> --
> IA64: a worthy successor to i860.
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
>
