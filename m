Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRC3LlS>; Fri, 30 Mar 2001 06:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRC3LlJ>; Fri, 30 Mar 2001 06:41:09 -0500
Received: from [200.248.92.2] ([200.248.92.2]:4113 "EHLO
	svrdomino.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S131316AbRC3Lk6> convert rfc822-to-8bit; Fri, 30 Mar 2001 06:40:58 -0500
From: =?iso-8859-1?q?Andr=E9?= <andre@sam.com.br>
Organization: Sam =?iso-8859-1?q?Inform=E1tica=20Ltda?=
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
   "Butter, Frank" <Frank.Butter@otto.de>
Subject: Re: WG: 2.4 on COMPQ Proliant
Date: Fri, 30 Mar 2001 08:42:04 -0300
X-Mailer: KMail [version 1.1.99]
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.32.0103291502040.25146-100000@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.32.0103291502040.25146-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Message-Id: <01033008420401.03013@dpd16>
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.6)
X-MIMETrack: Itemize by SMTP Server on svrdomino/Lojasrenner(Release 5.0.5 |September 22, 2000) at
 03/30/2001 08:38:57 AM,
	Serialize by Router on svrdomino/Lojasrenner(Release 5.0.5 |September 22, 2000) at
 03/30/2001 08:40:23 AM
Content-Type: text/plain;
  charset="X-UNKNOWN"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Quinta 29 Março 2001 20:02, Mr. James W. Laferriere escreveu:
> Hello Frank ,  Highly recommend the sym53c***** .  JimL
>
> On Thu, 29 Mar 2001, Butter, Frank wrote:
> > 2.2.16 claimes to find a ncr53c1510D-chipset, supported by
> > the driver ncr53c8xx. Which kernel-param would be the correct one for
> > this? Frank
> >
> > > -----Ursprüngliche Nachricht-----
> > > Von: Butter, Frank
> > > Gesendet: Donnerstag, 29. März 2001 17:11
> > > An: 'linux-kernel@vger.kernel.org'
> > > Betreff: 2.4 on COMPQ Proliant
> > > Has anyone experiences with 2.4.x on recent Compaq Proliant
> > > Servers (e.g. ML570)?
> > >
> > > I've installed RedHat7 and it worked fine out of the box.
> > > Except that the SMP-enabled kernel stated there was no
> > > SMP-board detected ;-/
> > > For some reasons (Fibrechannel drivers and so on) I've compiled
> > > 2.4.2 and installed it. Although I've compiled the support
> > > in, the NCR-SCSI-chip was not found and therefore no
> > > root-partition. It is a model supported by 53c8xx - detected
> > > by the original RedHat-kernel.
> > >
> > > For testing I compiled a kernel with all (!) scsi-low-level-drivers -
> > > with the same result. The SMP-board also was NOT detected by 2.4.2.
> > >
> > > Any hint?
> > >
> > > Frank
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>        +----------------------------------------------------------------+
>
>        | James   W.   Laferriere | System  Techniques | Give me VMS     |
>        | Network        Engineer | 25416      22nd So |  Give me Linux  |
>        | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
>
>        +----------------------------------------------------------------+
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



Hello EveryBody,



I have a COMPAQ ML570 (2xPIII-700Mhz/1MBytes Cache, 2 x NCR SCSI controller, 
1 SMART ARRAY 5304 (128 MBytes Cache). I test with linux 2.4.2-ac20, and all 
disks, CPU's and memory have been detected by the KERNEL.


See your BIOS Version, My COMPAQ has BIOS P20 01/21/2001, I download from 
compaq.com



Best Regards


André Margis
