Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285425AbRLNR1i>; Fri, 14 Dec 2001 12:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285427AbRLNR12>; Fri, 14 Dec 2001 12:27:28 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S285425AbRLNR1N>;
	Fri, 14 Dec 2001 12:27:13 -0500
Message-ID: <0ece01c184c4$9a23abd0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: "Thomas Capricelli" <orzel@kde.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <0ea901c184c2$896fc550$5601010a@prefect>  <0e8901c184c1$248476a0$5601010a@prefect> <0ddd01c184b3$ce15c470$5601010a@prefect> <066801c183f2$53f90ec0$5601010a@prefect> <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <25867.1008323156@redhat.com> <13988.1008348675@redhat.com> <15374.1008349429@redhat.com>  <16533.1008350197@redhat.com>
Subject: Re: Mounting a in-ROM filesystem efficiently 
Date: Fri, 14 Dec 2001 12:27:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "David Woodhouse" <dwmw2@infradead.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Thomas Capricelli" <orzel@kde.org>; <linux-kernel@vger.kernel.org>
Sent: Friday, December 14, 2001 12:16 PM
Subject: Re: Mounting a in-ROM filesystem efficiently


>
> brad@ltc.com said:
> >  They do.  On that system just the low-level flash write code was kept
> > in RAM, but the rest of the kernel was XIP from flash.
>
> Oh, right - so you run from RAM and disable interrupts while you're
writing
> or erasing?

Correct.

Regards,
Brad

