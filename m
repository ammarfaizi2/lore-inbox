Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269549AbRHLXFS>; Sun, 12 Aug 2001 19:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269547AbRHLXFI>; Sun, 12 Aug 2001 19:05:08 -0400
Received: from oe18.law11.hotmail.com ([64.4.16.122]:58638 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S269546AbRHLXEz>;
	Sun, 12 Aug 2001 19:04:55 -0400
X-Originating-IP: [24.10.60.231]
From: "Dan Mann" <daniel_b_mann@hotmail.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108121506100.18332-100000@druid.if.uj.edu.pl>
Subject: Re: VM nuisance
Date: Sun, 12 Aug 2001 19:05:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <OE18Y30kkZIhTrBoe2U00004e33@hotmail.com>
X-OriginalArrivalTime: 12 Aug 2001 23:05:02.0627 (UTC) FILETIME=[37C28F30:01C12383]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik Said:

> > No.  The problem is that whenever I change something to
> > the OOM killer I get flamed.
> >
> > Both by the people for whom the OOM killer kicks in too
> > early and by the people for whom the OOM killer now doesn't
> > kick in.
> >
> > I haven't got the faintest idea how to come up with an OOM
> > killer which does the right thing for everybody.

Would there be a way that you could have a proc interface to adjust the
sensitivity of the OOM killer so that users could raise or lower the
threshold that causes OOM killer activation?  Hopefully you wouldn't get any
flak for that unless users start blaming you for their own settings :-)

Most people would just use the standard setting that you provide...but
others that felt the need could change it on their system.

Dan
