Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292712AbSBZTMv>; Tue, 26 Feb 2002 14:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292718AbSBZTMd>; Tue, 26 Feb 2002 14:12:33 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:65171 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S292712AbSBZTMY>; Tue, 26 Feb 2002 14:12:24 -0500
Message-ID: <009301c1bef9$84dee9a0$030ba8c0@mistral>
From: "Simon Turvey" <turveysp@ntlworld.com>
To: "David Rees" <dbr@greenhydrant.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fmJt-0001Xi-00@the-village.bc.nu> <006e01c1bef6$6dd78e40$030ba8c0@mistral> <20020226110134.B11982@greenhydrant.com>
Subject: Re: IDE error on 2.4.17
Date: Tue, 26 Feb 2002 19:12:22 -0000
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

It's a dev box anyway - just for tinkering.  Even so, it's annoying.

Someone asked what the drive model was:  IBM-DTLA-305030.

Will send the bugger back in the morning.

----- Original Message -----
From: "David Rees" <dbr@greenhydrant.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 26, 2002 7:01 PM
Subject: Re: IDE error on 2.4.17


> On Tue, Feb 26, 2002 at 06:50:15PM -0000, Simon Turvey wrote:
> > The drive's less than a year old :-(
> >
> > Should I try disabling some of the UDMA stuff?
>
> Age of the disk doesn't matter, they'll die at any age.  They seem to die
> most frequently either within one year, or after 3 years.
>
> Turning off UDMA probably won't help, it looks like it's time to restore
> from backups.  If you try to recover data from the disk, make sure you
mount
> it in read-only mode if you can get the drive that far up if you reboot.
>
> -Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


