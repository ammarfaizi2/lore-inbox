Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262336AbRENRar>; Mon, 14 May 2001 13:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262345AbRENRah>; Mon, 14 May 2001 13:30:37 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:11793 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S262336AbRENRaT>; Mon, 14 May 2001 13:30:19 -0400
Date: Mon, 14 May 2001 12:29:56 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200105141729.MAA28295@tomcat.admin.navo.hpc.mil>
To: alan@lxorguk.ukuu.org.uk, meissner@spectacle-pond.org (Michael Meissner)
Subject: Re: Not a typewriter
In-Reply-To: <E14zLj4-0000zO-00@the-village.bc.nu>
Cc: vonbrand@sleipnir.valparaiso.cl (Horst von Brand),
        mharris@opensourceadvocate.org (Mike A. Harris), Wayne.Brown@altec.com,
        hacksaw@hacksaw.org (Hacksaw),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> > IIRC, the 6 character linker requirement came from when the Bell Labs folk
> > ported the C compiler the IBM mainframe world, not from the early UNIX (tm)
> > world.  During the original ANSI C meetings, I got the sense from the IBM rep,
> 
> 6 character linker name limits are very old. Honeywell L66 GCOS3/TSS which I
> had the dubious pleasure of experiencing and which is a direct derivative of
> GECOS and thus relevant to the era like many 36bit boxes uses 6 char link names
> 
> Why - well because 6 BCD characters fit in a 36bit word and its a single compare
> to check symbol matches

well... actually it was 6 bit "ascii" computed from: (char - ' '). Depends
entirely on architecture, and implementation. EBCD/6Bit/7Bit and EBCDIC were
supported on the Honeywell systems.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
