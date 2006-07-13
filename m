Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWGMMZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWGMMZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWGMMZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:25:51 -0400
Received: from mail.gmx.net ([213.165.64.21]:33232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751013AbWGMMZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:25:51 -0400
Cc: johnstul@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 13 Jul 2006 14:25:49 +0200
From: "Uwe Bugla" <uwe.bugla@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0607122039490.12900@scrub.home>
Message-ID: <20060713122549.120700@gmx.net>
MIME-Version: 1.0
References: <20060712115110.292550@gmx.net>
 <Pine.LNX.4.64.0607121410580.12900@scrub.home> <20060712123917.18970@gmx.net>
 <Pine.LNX.4.64.0607122039490.12900@scrub.home>
Subject: Re: Re: Re: patch for timer.c - two dmesgs
To: Roman Zippel <zippel@linux-m68k.org>
X-Authenticated: #8359428
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-------- Original-Nachricht --------
Datum: Wed, 12 Jul 2006 20:41:40 +0200 (CEST)
Von: Roman Zippel <zippel@linux-m68k.org>
An: Uwe Bugla <uwe.bugla@gmx.de>
Betreff: Re: Re: patch for timer.c - two dmesgs

> Hi,
> 
> On Wed, 12 Jul 2006, Uwe Bugla wrote:
> 
> > > A lot has changed since then...
> > > Did you try using SysRq+P or Alt+ScrollLock? (A SysRq+T might be
> useful 
> > > too).
> > Sorry for this stupid sounding question:
> > At what point of the boot process do I have to use those keyboard
> combinations please? And what is the output / product of them please?
> 
> Just press them the boot stops and send the kernel log or wite it down if 
> it's not in the log.
> 
> bye, Roman

Thanks, Roman.
To avoid misunderstandings:
I in fact invest more time and energy in testing mm- or other kernels than any comparable user or admin. I in fact tested 3 or 4 different ones somewhere between 2.6.17 and 2.6.18-rc1-mm1, but got exhausted and demotivated as the only output was inability to boot.
I informed Andrew as quick as possible. And I never in my life stumbled over kernels behaving like this. In so far as a consequence I am missing tools or tricks how to produce system output for constructive feedback.
 Question: What difference is there between the output of dmesg when kernel stops out of inconvenience or just out of containing buggy code on the one hand and the output of SysRq+P or Alt+ScrollLock on the other hand?

Regards
Uwe

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
