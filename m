Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284519AbRLMSGt>; Thu, 13 Dec 2001 13:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284518AbRLMSGj>; Thu, 13 Dec 2001 13:06:39 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S284500AbRLMSGV>;
	Thu, 13 Dec 2001 13:06:21 -0500
Message-ID: <07ab01c18400$e432de90$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "David Woodhouse" <dwmw2@infradead.org>,
        "Thomas Capricelli" <orzel@kde.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011213163912.5741223CCD@persephone.dmz.logatique.fr>  <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <066801c183f2$53f90ec0$5601010a@prefect>  <1116.1008265740@redhat.com>
Subject: Re: Mounting a in-ROM filesystem efficiently 
Date: Thu, 13 Dec 2001 13:06:29 -0500
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
To: "Thomas Capricelli" <orzel@kde.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 13, 2001 12:49 PM
Subject: Re: Mounting a in-ROM filesystem efficiently

> orzel@kde.org said:
> >  Does it mean that NONE of the existing embedded linux is able to use
> > a ROM  directly as a filesystem ?? (either root fs or not)
>
> Out of the box, no. XIP isn't that interesting. Most boxes have flash, and
> flash is more expensive than RAM

Dollar-wise, but not power-wise.

Regards,
Brad

