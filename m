Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbSJCMEc>; Thu, 3 Oct 2002 08:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbSJCMEc>; Thu, 3 Oct 2002 08:04:32 -0400
Received: from NS-1.iNES.RO ([80.86.96.6]:48553 "EHLO Master.iNES.RO")
	by vger.kernel.org with ESMTP id <S263238AbSJCMEb>;
	Thu, 3 Oct 2002 08:04:31 -0400
Subject: Re: problem with cpufreq
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003112957.GA1126@debian>
References: <20021003112957.GA1126@debian>
Content-Type: text/plain
Organization: iNES Advertising
Message-Id: <1033647006.1140.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 03 Oct 2002 15:10:06 +0300
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (Master.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,


Check your bios setup about CPU speed.
I am using right now an Sattelite Pro 4300.

And I don't think this model is supported by cpufreq
(it has an 440BX Chipset)

//Cioby




On Jo, 2002-10-03 at 14:29, Stephane Wirtel wrote:
> hi !
> 
> i have a problem with my computer, 
> on the description of my CPU, it's a Pentium 3 Coppermine 650Mhz,
> when i do a "cat /proc/cpuinfo", the frequence is not 650, but 333Mhz.
> this computer is a portable Toshiba Satellite Pro 4300
> could you help me ?
> 
> thanks, 
> 
> Best regards, 
> 
> 
> Stephane Wirtel
> 
> -- 
> Stephane Wirtel <stephane.wirtel@belgacom.net>
> Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
> OS3B : Club OpenSoftware Carolo : www.os3b.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

