Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRIFX4E>; Thu, 6 Sep 2001 19:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRIFXz4>; Thu, 6 Sep 2001 19:55:56 -0400
Received: from st-207-63-161-6.cm201u.will.k12.il.us ([207.63.161.6]:34426
	"HELO gwia.cm201u.org") by vger.kernel.org with SMTP
	id <S268957AbRIFXzr>; Thu, 6 Sep 2001 19:55:47 -0400
Date: Fri, 7 Sep 2001 01:55:08 +0200
From: victor <ixnay@infonegocio.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: victor <ixnay@infonegocio.com>
X-Priority: 3 (Normal)
Message-ID: <2685246227.20010907015508@infonegocio.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: K7/Athlon optimizations again. (The sacrifices worked??) (VIA KT133A chipset)
In-Reply-To: <Pine.LNX.4.33.0109062352130.26515-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0109062352130.26515-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Luigi,

Friday, September 07, 2001, 12:01:50 AM, you wrote:

LG> On KT133A based MBs, I came trought at less 4 bios upgrades, and no
LG> problems at all. Usually I do not oveclock CPUs, so i keep 1.725 volts for
LG> vcore instead of 1.75, and system are just STABLE. In the reality setting
LG> 1.725 volts in the bios gives to my CPUs on abit MBs the right 1.75 volts,
LG> and setting 1.75 gives them 1.78/9. So I would suggest also to investigate
LG> if this light overvolt could be involved to create instabilities.
LG> I just made a test, and saw that on athlon 1.33 Ghz this volts diffecence
LG> creates a 5 degres difference when CPU is idle, and 7/8 when it is full
LG> loaded. And belive me, actually i am keeping thos CPU in a 18 degrees
LG> environment, using delta's fan to dissipate the eath.

look at this
http://bp6.gamesquad.net/Q6fix.phtml
i have a bp6 who has the same problem whit the dual celeron, and here
is the solution for it, looks your motherboard and see if its the same
problem, the celerons are fine whit this overvolt, they are prety
stable

its abit ... it cuold be ;)

LG> I know that a light overvolt should increase stability, and not generate
LG> instability, but maybe if CPUs and north bridge get too hot, (not
LG> so hot to destroy the HW, but anyway hotter in front of the optimal
LG> temperature), that could generate instability on loaded systems.

LG> just my 2 cents

LG> Luigi

-- 
Best regards,
 victor                            mailto:ixnay@infonegocio.com

