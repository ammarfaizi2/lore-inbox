Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbUKJXL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbUKJXL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUKJXL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:11:27 -0500
Received: from smtpout.mac.com ([17.250.248.89]:11220 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262144AbUKJXLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:11:19 -0500
In-Reply-To: <419283EF.8050708@tmr.com>
References: <87actqfigw.fsf@sanosuke.troilus.org> <87actqfigw.fsf@sanosuke.troilus.org> <200411092328.16426.dtor_core@ameritech.net> <419283EF.8050708@tmr.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <87686367-336D-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=3D=3Futf-8=3Fq=3FRapha=EBl_Rigo_LKML=3F=3D?= 
	<lkml@twilight-hall.net>,
       Michael Poole <mdpoole@troilus.org>, davids@webmaster.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL Violation of 'sveasoft' with GPL Linux Kernel/Busybox +code
Date: Wed, 10 Nov 2004 18:09:10 -0500
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2004, at 16:11, Bill Davidsen wrote:
> That web page seems pretty clear... some parts of the prerelease are
> non-GPL, you can distribute the GPL code as usual. Unless there is
> some claim that the non-GPL parts are derived from GPL original
> source or contain GPL code, why shouldn't they restrict the 
> distribution
> of their own code?

The make it difficult if not effectively impossible to separate the two,
claiming that therefore they are not under the restrictions of the GPL.
However, the GPL _clearly_ states that if it is distributed as a single
work, then all parts _must_ be distributable under the terms of the
GPL.  I believe that a single binary firmware image is a single "work"
according to the definition provided in the GPL, and therefore by
distributing their code as a part of it, they have implicitly applied 
the
GPL to said work (assuming it was not GPLed already for other
reasons).

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


