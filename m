Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRIGAJO>; Thu, 6 Sep 2001 20:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269454AbRIGAJE>; Thu, 6 Sep 2001 20:09:04 -0400
Received: from adsl-64-171-25-65.dsl.sntc01.pacbell.net ([64.171.25.65]:4176
	"HELO top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S269413AbRIGAIx>; Thu, 6 Sep 2001 20:08:53 -0400
From: brian@worldcontrol.com
Date: Thu, 6 Sep 2001 17:15:53 -0700
To: Nicholas Knight <tegeran@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: K7/Athlon optimizations again. (The sacrifices worked??) (VIA KT133A chipset)
Message-ID: <20010906171553.A4484@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Nicholas Knight <tegeran@home.com>, linux-kernel@vger.kernel.org
In-Reply-To: <01090613553103.00465@c779218-a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01090613553103.00465@c779218-a>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 10 Athlon/Duron based machines under my control.

Among the motherboards are:

Iwill KK266
Epox 8KTA2L
Epox 8KTA3+
FIC AZ11

They have various speeds of Athlons and Durons.  All are
standard (not overclocked) and have lots of cooling.

They all have oopses when trying to boot 2.4.9ac5 with Athlon/Duron
selected as the processor type.  They all work fine with  
6x86 or K6/K6-2/K6-3 selected as processor type.  (when not
running 2.4, they are running 2.2.19, and will do so for
months at a time).

Previously all the machines were in use so I couldn't offer
much assistance.  However, an Epox 8KTA2L/Duron 900MHz is
not being used at the moment, so if someone wants me to
try a patch or something I'd be happy too.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
