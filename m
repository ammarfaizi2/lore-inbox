Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWBWPuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWBWPuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWBWPuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:50:46 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:19942 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751463AbWBWPup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:50:45 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 23 Feb 2006 16:48:20 +0100
To: schilling@fokus.fraunhofer.de, herbert@13thfloor.at
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [OT] portable Makefiles (was: CD writing in future Linux 
 (stirring up a hornets' nest))
Message-ID: <43FDD944.nailFUE21NE9H@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <200602171502.20268.dhazelton@enter.net>
 <43F9D771.nail4AL36GWSG@burner>
 <200602201302.05347.dhazelton@enter.net>
 <43FAE10F.nailD121QL6LN@burner>
 <20060221101644.GA19643@merlin.emma.line.org>
 <43FAF2FA.nailD12BW90DH@burner>
 <20060221114625.GA29439@merlin.emma.line.org>
 <43FC68C1.nailEC711MJAV@burner>
 <20060223081257.GA28833@MAIL.13thfloor.at>
In-Reply-To: <20060223081257.GA28833@MAIL.13thfloor.at>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:

> On Wed, Feb 22, 2006 at 02:36:01PM +0100, Joerg Schilling wrote:
> > ??? smake _is_ a real world make program and if you rate POSIX compliance
> > and portability, it will outstrip all other known make programs.
>
> does anybody (except for the author, of course) use
> smake for building their stuff? just curious ..

Many people use smake on platforms where there is no other
sufficiently compliant make program.

As GNU make incorrectly states to run on many plaforms, there are 
a lot of people who suffer from the fact that GNU make is not maintained
since > 6 years.

Note that I did make bug reports against GNU make that have been accepted as 
bugs but never fixed!

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
