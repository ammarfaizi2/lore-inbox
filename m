Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbRE0CnE>; Sat, 26 May 2001 22:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbRE0Cmz>; Sat, 26 May 2001 22:42:55 -0400
Received: from mail.alphalink.com.au ([203.24.205.7]:25374 "EHLO
	mail.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S262722AbRE0Cmf>; Sat, 26 May 2001 22:42:35 -0400
Message-ID: <3B106BE6.78F9DCC4@alphalink.com.au>
Date: Sun, 27 May 2001 12:52:22 +1000
From: Greg Banks <gnb@alphalink.com.au>
X-Mailer: Mozilla 4.07 [en] (X11; I; Linux 2.2.1 i586)
MIME-Version: 1.0
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
CC: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <E153pEG-0008RL-00@the-village.bc.nu> <01ce01c0e64c$b6cc01e0$52a6b3d0@Toshiba> <3B1061FC.EB18967A@alphalink.com.au> <029901c0e652$a108f740$52a6b3d0@Toshiba>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> 
> "Greg Banks" <gnb@alphalink.com.au> wrote:
> >
> >   I have some code which could become the basis for such a thing.
> > It's a touch panel driver for the DMIDA but it also has a device-
> > independent layer which does supersampling, scaling, provides
> > raw and cooked Linux Input interfaces, and a /proc interface to
> > allow the calibration app to control the scaling.
> >
> >   Unfortunately I can't release it yet for (ahem) legal reasons.
> >
> 
> nice job , from where you get the related specs ?

  From the manufacturer.  We had the fullest possible co-operation
including all technical specs, several sample machines, source to
the WinCE drivers for the hardware, and engineers (including the lead
hardware designer, a *very* cluey gentleman) on standby to answer
questions.

  It makes an amazing difference to have all the nasty little
hardware quirks and known workarounds for them laid bare before you.

Greg.
-- 
If it's a choice between being a paranoid, hyper-suspicious global
village idiot, or a gullible, mega-trusting sheep, I don't look
good in mint sauce.                      - jd, slashdot, 11Feb2000.
