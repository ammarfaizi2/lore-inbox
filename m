Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285415AbRLNRC5>; Fri, 14 Dec 2001 12:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbRLNRCi>; Fri, 14 Dec 2001 12:02:38 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S285415AbRLNRC3>;
	Fri, 14 Dec 2001 12:02:29 -0500
Message-ID: <0e8901c184c1$248476a0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: "Thomas Capricelli" <orzel@kde.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <0ddd01c184b3$ce15c470$5601010a@prefect>  <066801c183f2$53f90ec0$5601010a@prefect> <20011213160007.D998D23CCB@persephone.dmz.logatique.fr> <25867.1008323156@redhat.com>  <13988.1008348675@redhat.com>
Subject: Re: Mounting a in-ROM filesystem efficiently 
Date: Fri, 14 Dec 2001 12:02:41 -0500
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
Sent: Friday, December 14, 2001 11:51 AM
Subject: Re: Mounting a in-ROM filesystem efficiently 

> >  Actually, I've used that patch on a system that had a cramfs/xip and
> > a jffs partition on the same flash chip where the kernel was running
> > xip out of flash.  :-) 
> 
> S'OK if you have the right type of flash chips, I suppose :)

128 Mbit Intel StrataFlash.

Regards,
Brad

