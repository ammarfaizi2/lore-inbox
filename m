Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSJOQCa>; Tue, 15 Oct 2002 12:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSJOQCa>; Tue, 15 Oct 2002 12:02:30 -0400
Received: from Bay.UH.EDU ([129.7.235.4]:61958 "EHLO Bayou.UH.EDU")
	by vger.kernel.org with ESMTP id <S262646AbSJOQC2> convert rfc822-to-8bit;
	Tue, 15 Oct 2002 12:02:28 -0400
Date: Tue, 15 Oct 2002 11:08:19 -0500 (CDT)
From: Pranav Desai <prdesai@Bayou.UH.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: Booting problem with VIA C3 400A CPU
In-Reply-To: <3DABD66B.1060904@corvil.com>
Message-ID: <Pine.OSF.4.44.0210150956050.1352298-100000@bay.uh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
	Yes it was built for 686. I didnt realize that this could be a
problem. Now everything is working fine.  Does glibc built for 386 have
any kind of impact on the system in terms of performance?

Thanks a lot for the help and sorry for the trouble.
-Pranav

*************************************************************
Pranav A. Desai

Home - (937) 294 1381
Off. - (937) 224 0485 (x123)
*************************************************************

On Tue, 15 Oct 2002, Padraig Brady wrote:

> Pranav Desai wrote:
> > Hi all!
> > 	I am not sure if this a bug, but when I try to boot kernel 2.4.18
> > it stops just before init starts. It doesnt hang because ctrl+alt+del does
> > reboot the system. I tried kernels with 386 and cyrix processors but with
> > the same result.
>
> Is your glibc built for 686 (CMOV) ?
> Pádraig.
>
>


