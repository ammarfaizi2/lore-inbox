Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbTASJkg>; Sun, 19 Jan 2003 04:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTASJkg>; Sun, 19 Jan 2003 04:40:36 -0500
Received: from smtp.laposte.net ([213.30.181.7]:53899 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S266408AbTASJkf>;
	Sun, 19 Jan 2003 04:40:35 -0500
Message-ID: <006f01c2bfa0$06b51b00$0eb63851@vaio>
From: "Florent CHANTRET" <florent@chantret.com>
To: "Manfred Spraul" <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
References: <3E29C3E4.4010304@colorfullife.com>
Subject: Re: [INTEL PII BUG] Still SMBALERT# spontaneous shutdown on VAIO Serie F
Date: Sun, 19 Jan 2003 10:49:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've already updated my bios to the last revision but Sony give a poor
support to those customers. I won't buy a VAIO anymore !

As I've read on the website spokin' about VAIO problems, the problem seems
to be connected to that, but yes, why not, it could be the SMI handler too.
I only know that the sotware could solve it antd that's one of the several
power of Linux other Windows.

Regards,
Florent CHANTRET

----- Original Message -----
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Florent CHANTRET" <florent@chantret.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 18, 2003 10:15 PM
Subject: Re: [INTEL PII BUG] Still SMBALERT# spontaneous shutdown on VAIO
Serie F


> >
> >
> >Still having the problem of the spontaneous shutdown on a VAIO serie F
> >laptop due to a bug in the thermal sensor of the PII celeron. There is no
> >ACPI, nor APM, nor I2C / SMBus builded in the kernel.
> >
> >
> Are you sure that the shutdown is connected to the errata?
>
> The system shutdown is probably triggered by the BIOS SMI handler - SMI
> can interrupt the linux kernel, and the bios takes over control of the
> system.
>
> Are there any bios upgrades for laptop?
>
> --
>     Manfred
>
>
>
>


---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.443 / Virus Database: 248 - Release Date: 10/01/03

