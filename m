Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285474AbRLSUWk>; Wed, 19 Dec 2001 15:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285466AbRLSUWd>; Wed, 19 Dec 2001 15:22:33 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:45955 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S285474AbRLSUVs>; Wed, 19 Dec 2001 15:21:48 -0500
To: linux-kernel@vger.kernel.org, linux@sneulv.dk
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
Message-Id: <E16GnOs-0000JT-00@DervishD.viadomus.com>
Date: Wed, 19 Dec 2001 21:33:14 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))

>> Is it safe to use gcc-3.0.2 to compile the kernel?
>If it compiles.. Otherwise use gcc-3.0.3(prerelease), it has fixes that makes 
>the _current_ kernel compile. 

    I've using gcc-3.0.1 to compile the kernel since it was released
and my linux 2.4.16 runs without problems. In my experience, the only
problem is the ICE raised by the 8139too driver, although this seems
to have been corrected on gcc-3.0.2 (I haven't updated my compiler
yet). I haven't found any bug yet running my linux box, but this
doesn't mean that gcc-3.0 is safe for the kernel. It's safe for my
configuration of the kernel, at least.

    Raúl
