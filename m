Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSFEKYG>; Wed, 5 Jun 2002 06:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSFEKYF>; Wed, 5 Jun 2002 06:24:05 -0400
Received: from [212.176.239.134] ([212.176.239.134]:40095 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S314491AbSFEKYD>; Wed, 5 Jun 2002 06:24:03 -0400
Message-ID: <000c01c20c7a$a5c527a0$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020604143643.5024C-100000@gatekeeper.tmr.com>
Subject: Re: 2.4.19-pre8-ac5 ide & raid0 bugs
Date: Wed, 5 Jun 2002 14:20:41 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17FXuE-0006uH-00*q6o73JjUhlg* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No, I don't have task_file enabled.

> > I wrote about ide problems with 2.4.19-pre8 a few days ago (it just
trashed
> > filesystem in a couple hours) & I was told to try 2.4.19-pre8-ac5 it was
a
> > little bit better though every 5-8 hours I've got ide errors in log (at
> > least it didn't crash my reiserfs volumes yet):
>
> I see a lot of the 0x58 with taskfile enabled, are you doing that? I even
> see it mounting an "IDE" compact flash! I ran out of time to try w/o
> taskfile_io.


