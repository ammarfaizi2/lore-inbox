Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRC2XDt>; Thu, 29 Mar 2001 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRC2XDj>; Thu, 29 Mar 2001 18:03:39 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:35344 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S129408AbRC2XDa> convert rfc822-to-8bit; Thu, 29 Mar 2001 18:03:30 -0500
Date: Thu, 29 Mar 2001 15:02:46 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "Butter, Frank" <Frank.Butter@otto.de>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: WG: 2.4 on COMPQ Proliant
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271B9E1@NTOVMAIL04>
Message-ID: <Pine.LNX.4.32.0103291502040.25146-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Frank ,  Highly recommend the sym53c***** .  JimL

On Thu, 29 Mar 2001, Butter, Frank wrote:
> 2.2.16 claimes to find a ncr53c1510D-chipset, supported by
> the driver ncr53c8xx. Which kernel-param would be the correct one for this?
> Frank
> > -----Ursprüngliche Nachricht-----
> > Von: Butter, Frank
> > Gesendet: Donnerstag, 29. März 2001 17:11
> > An: 'linux-kernel@vger.kernel.org'
> > Betreff: 2.4 on COMPQ Proliant
> > Has anyone experiences with 2.4.x on recent Compaq Proliant
> > Servers (e.g. ML570)?
> >
> > I've installed RedHat7 and it worked fine out of the box.
> > Except that the SMP-enabled kernel stated there was no
> > SMP-board detected ;-/
> > For some reasons (Fibrechannel drivers and so on) I've compiled
> > 2.4.2 and installed it. Although I've compiled the support
> > in, the NCR-SCSI-chip was not found and therefore no
> > root-partition. It is a model supported by 53c8xx - detected
> > by the original RedHat-kernel.
> >
> > For testing I compiled a kernel with all (!) scsi-low-level-drivers -
> > with the same result. The SMP-board also was NOT detected by 2.4.2.
> >
> > Any hint?
> >
> > Frank
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

