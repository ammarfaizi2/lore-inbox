Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272442AbRIKNA1>; Tue, 11 Sep 2001 09:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272448AbRIKNAQ>; Tue, 11 Sep 2001 09:00:16 -0400
Received: from [24.254.60.23] ([24.254.60.23]:34535 "EHLO
	femail33.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272442AbRIKNAJ>; Tue, 11 Sep 2001 09:00:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Jonathan Morton <chromi@cyberspace.org>,
        Roberto Jung Drebes <drebes@inf.ufrgs.br>
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel crash)
Date: Tue, 11 Sep 2001 05:59:41 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a05100303b7c3a4283667@[192.168.239.101]>
In-Reply-To: <a05100303b7c3a4283667@[192.168.239.101]>
MIME-Version: 1.0
Message-Id: <01091105594100.00173@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 September 2001 04:21 am, Jonathan Morton wrote:
> >Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo
> > KT133A chipset). The kernel I had (2.4.9) started crashing on boot
> > with an invalid page fault, usually right after starting init. I
> > tryed a i686 kernel and noticed it works OK, so I recompiled my
> > crashy kernel only switching the processor type and it also worked.
> > changed it back to Athlon/K7/Duron and it starts crashing.
> >
> >Anyone else experiencing this?
>
> BINGO!
>
> This problem is known about, but this is the first report we've had
> of it on a Duron (as opposed to Athlon), and you've successfully
> tracked it down to the updated BIOS.
>

Actually we've had a couple reports on Durons on KT133A chipsets failing.
We've only had a couple reports of BIOS versions making a difference 
though, and it was never really clear which version did what.

> We need the versions of your old and new BIOSes, as accurately as you
> can make it.

Can someone compare the INTERNAL BIOS versions (as opposed to the 
external reported by the motherboard manufacturer)?
