Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSGHV74>; Mon, 8 Jul 2002 17:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317184AbSGHV7z>; Mon, 8 Jul 2002 17:59:55 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:11838 "EHLO
	devil.stev.org") by vger.kernel.org with ESMTP id <S317182AbSGHV7z>;
	Mon, 8 Jul 2002 17:59:55 -0400
Message-ID: <006101c226ca$d0c9a380$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: <jbradford@dial.pipex.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200207082159.WAA03443@darkstar.example.net>
Subject: Re: ATAPI + cdwriter problem
Date: Mon, 8 Jul 2002 23:00:03 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> What's the make and model of your CD-writer?  There are known firmware
bugs with a lot of them.

its a Benq 32x10x40 CD/RW
running with the Promise ATA/133 controller


seems strange ide-scsi is the only thing i have ever had problems with.
i know it also does not work with the other 2 cd drives in the machine as
well.
1 is an old HP 2x2x6 7200+ writer (writes ok reading problems)
and a normall 44x reader(will causes opps on reading bad media)

i have sent the oppen to the list before but they have always been ignored.

> John.
>
> > Hi
> >
> > i have  bunch of messages like these and a hung cd writer
> >
> > scsi : aborting command due to timeout : pid 28231, scsi0, channel 0, id
2,
> > lun 0 Test Unit Ready 00 00 00 00 00
> > SCSI host 0 abort (pid 28231) timed out - resetting
> > SCSI bus is being reset for host 0 channel 0.
> > hdg: ATAPI reset timed-out, status=0xd0
> > PDC202XX: Secondary channel reset.
> > ide3: reset: success
> > hdg: irq timeout: status=0xc0 { Busy }
> > hdg: status timeout: status=0xd0 { Busy }
> > hdg: drive not ready for command
> >
> >
> > anyone be able to suggest any action to help prevent it in the future ?
> >
> > thanks
> >     James
> >
> > --------------------------
> > Mobile: +44 07779080838
> > http://www.stev.org
> >   7:10pm  up 57 min,  3 users,  load average: 2.05, 1.84, 1.10
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


