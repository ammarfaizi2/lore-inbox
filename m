Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSHCTYr>; Sat, 3 Aug 2002 15:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSHCTYr>; Sat, 3 Aug 2002 15:24:47 -0400
Received: from ns1.baby-dragons.com ([199.33.245.254]:58815 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S317415AbSHCTYp>; Sat, 3 Aug 2002 15:24:45 -0400
Date: Sat, 3 Aug 2002 15:27:44 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19
In-Reply-To: <Pine.LNX.4.44.0208022113570.3863-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0208031520560.20471-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Marcelo ,  Ummmm .  Haven't the tarballs usuaully been
	archived as 'linux/' instead of 'linux-2.4.19/' ?

	I am also finding atm driver files touched but no obvious entries
	in the ChangeLog .  ie: linux-2.4.19/drivers/atm/fore200e.c
	touched '2002-08-02 20:39' by tar archive time stamp .

	The below are the only entries in the ChangeLog file that directly
	mention ATM .  ??? ,  Tia,  JimL

23965-<rusty@rustcorp.com.au> (02/06/03 1.461)
24006:  [PATCH] Trivial 2.4.19-pre9: check_region in drivers/atm/horizon.c
24074-
--
38191-<ldb@ldb.ods.org> (02/05/20 1.445.2.7)
38230:  [PATCH] Fix PPPoATM crash on disconnection
38274-
--
56257-<maxk@qualcomm.com> (02/04/29 1.383.2.89)
56299:  Add support for ATM Ethernet bridging (RFC 2684)
56349-

JimL

On Fri, 2 Aug 2002, Marcelo Tosatti wrote:
> final:
> - 2.4.19-rc5 was released as 2.4.19 with no changes.

> Summary of changes from v2.4.19-rc4 to v2.4.19-rc5
> ============================================
> <davem@redhat.com> (02/08/01 1.662)
> 	[PATCH] Correct openprom fix
> 	   <davem@redhat.com> (02/07/31 1.661)
> 	   	[PATCH] Add missing check to openprom driver
> <akpm@zip.com.au> (02/08/01 1.663)
> 	[PATCH] disable READA
> <marcelo@plucky.distro.conectiva> (02/08/01 1.664)
> 	Change EXTRAVERSION to -rc5

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

