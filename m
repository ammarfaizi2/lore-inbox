Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSGJQMq>; Wed, 10 Jul 2002 12:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317531AbSGJQMq>; Wed, 10 Jul 2002 12:12:46 -0400
Received: from dsl-216-227-40-121.telocity.com ([216.227.40.121]:35731 "HELO
	mail.shirleyfamily.net") by vger.kernel.org with SMTP
	id <S317520AbSGJQMp>; Wed, 10 Jul 2002 12:12:45 -0400
From: "Bill Shirley" <bill@shirleyfamily.net>
To: "'Tomas Konir'" <moje@molly.vabo.cz>,
       "'Anton Altaparmakov'" <aia21@cantab.net>
Cc: "'Matthias Andree'" <matthias.andree@stud.uni-dortmund.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: IBM Desktar disk problem?
Date: Wed, 10 Jul 2002 12:15:17 -0400
Message-ID: <005201c2282c$fbe42460$0404a8c0@lan.shirleyfamily.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44L0.0207052306170.4516-100000@moje.ich.vabo.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps you should try:
http://www.storage.ibm.com/hdd/support/download.htm
it has a linux version.


Bill Shirley


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Tomas Konir
Sent: Friday, July 05, 2002 5:09 PM
To: Anton Altaparmakov
Cc: Matthias Andree; linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?


On Fri, 5 Jul 2002, Anton Altaparmakov wrote:

> >I have no broken blocks. Only two errors logged in S.M.A.R.T.
> >I have no S.M.A.R.T. errors for one year ago. And after use TCQ there
are
> >two errors after two days. Is is normal ?
> >Curently i not believe new IBM disks and TCQ. I'll wait for better
disks
> >and stable TCQ.
>
> You should update your firmware regardless of using TCQ because the
errors
> you experienced have nothing to do with TCQ but a lot to do with buggy
> firmware. See what I found written about the firmware update on this
> webpage (Phil Randal posted this URL earlier on in this thread):
>          http://www.geocities.com/dtla_update/
>

I know this page, but firmware upgrade need windows and i have no
windows
and there are no windows near me. I'll try to find windows and upgrade
it.
Thanks for your advice.

> ---snip---
> While S.M.A.R.T. offline scan running in background, a read error
could
> cause a potential failure. This is corrected with current microcode.
>
> (A5AA/A6AA) will detect and prevent application specific usage
patterns
> that cause excessive dwell times in particular areas.
> ---snip---
>
> Best regards,
>
> Anton

	MOJE

--
Tomas Konir
Brno
ICQ 25849167


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

