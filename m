Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSFPAiL>; Sat, 15 Jun 2002 20:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSFPAiK>; Sat, 15 Jun 2002 20:38:10 -0400
Received: from adsl-216-62-201-136.dsl.austtx.swbell.net ([216.62.201.136]:28559
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S315760AbSFPAiK>; Sat, 15 Jun 2002 20:38:10 -0400
Subject: Re: Dual Athlon 2000 XP MP nightmare
From: Austin Gonyou <austin@digitalroadkill.net>
To: Steve Cole <coles@vip.kos.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003101c214bb$0275a720$0a00000a@kos.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 15 Jun 2002 19:37:20 -0500
Message-Id: <1024187840.19232.3.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-15 at 17:21, Steve Cole wrote:
>  I'm not sure that what I'm experiencing is a kernel problem, but I thought
> I  would stick my foot in the door nonetheless, since I have no real
> indication of what is going on.


One thing which could remedy this is using the KDB. (kernel debugger) If
you get the -aa series kernels/patches you can get this functionality.
(Dunno if -ac has it built it). Once the machine crashes, as long as
it's not a black screen, then you can get a back-trace on the process
and even possibly find the section of code that's actually causing the
problem right off the bat,(not usual and YMMV), though probably not, but
it's an enormous amount of info that you can't get ATM.


> If it's hardware for sure, please just indicate that and I'll move on.  I'm
> getting semi-desperate. :(

-- 
Austin Gonyou <austin@digitalroadkill.net>
