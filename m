Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSFFTty>; Thu, 6 Jun 2002 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSFFTtw>; Thu, 6 Jun 2002 15:49:52 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:18670 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S317142AbSFFTti>; Thu, 6 Jun 2002 15:49:38 -0400
Message-ID: <000001c20d93$3e430b50$66aca8c0@kpfhome>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Tomas Szepe" <szepe@pinerecords.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000701c20d8a$7234b520$66aca8c0@kpfhome> <20020606191503.GH17859@louise.pinerecords.com>
Subject: Re: kbuild-2.5 2.4.19-pre10-ac2 "automatic" make installable?
Date: Thu, 6 Jun 2002 12:45:16 -0700
Organization: Laboratory Systems Group, Inc.
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

OK, my bad. I won't shoot myself in the foot again.

----- Original Message -----
From: "Tomas Szepe" <szepe@pinerecords.com>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, June 06, 2002 12:15 PM
Subject: Re: kbuild-2.5 2.4.19-pre10-ac2 "automatic" make installable?


> > <snip>?
> > ... and renamed Makefile to Makefile-2.4 and Makefile-2.5 to
> > Makefile (so I don't have to keep specifying -f Makefile-2.5).
>
> You are not supposed to do this. The original Makefile gets grepped
> for kernel version by kbuild 2.5. Your renaming the Makefiles is probably
> the cause of the seemingly automated rebuild.
>
> T.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

