Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286211AbRL0FVz>; Thu, 27 Dec 2001 00:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286212AbRL0FVq>; Thu, 27 Dec 2001 00:21:46 -0500
Received: from oe67.law14.hotmail.com ([64.4.20.202]:7172 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286211AbRL0FVl>;
	Thu, 27 Dec 2001 00:21:41 -0500
X-Originating-IP: [65.27.38.196]
From: "Idrigal \(Eric Rautenkranz\)" <darklordoflinux@hotmail.com>
To: "Legacy Fishtank" <garzik@havoc.gtf.org>,
        "Arturas V" <arturasv@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <F1331RVM0t2CD7Lsb0O0001005d@hotmail.com> <20011226174307.B14542@havoc.gtf.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
Date: Wed, 26 Dec 2001 23:21:43 -0600
Organization: Ion Networks, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE67G6IFTirpI7vaZRf00007bbf@hotmail.com>
X-OriginalArrivalTime: 27 Dec 2001 05:21:36.0045 (UTC) FILETIME=[5AAA8DD0:01C18E96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the model, also, some EEPro100s were buggy hardware wise, and
had problems with various MBs.
----- Original Message -----
From: "Legacy Fishtank" <garzik@havoc.gtf.org>
To: "Arturas V" <arturasv@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, 26 December, 2001 4:43 PM
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?


> On Wed, Dec 26, 2001 at 03:43:52PM -0500, Arturas V wrote:
> > We had similar problems with Compaq Proliant XEON EEPro100 NIC and
Compaq
> > Spart Array. System would periodically hang or panic. Problems went away
> > after I replaced EEPRO100 NIC with TLAN NICs(Texas instruments or
> > "Thunderland"). It's a good indication that there could be a problem
with
> > eepro driver.
>
> You not only replaced the driver but the hardware too.  So, that tells
> us nothing about the eepro100 driver really.
>
> Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
