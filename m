Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284187AbRLKWw3>; Tue, 11 Dec 2001 17:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284178AbRLKWwJ>; Tue, 11 Dec 2001 17:52:09 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:40937 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S284189AbRLKWwB>; Tue, 11 Dec 2001 17:52:01 -0500
Message-ID: <048e01c18294$7a497650$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.n0jjs6v.7ms98a@ifi.uio.no> <fa.jlqjvuv.348ign@ifi.uio.no>
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
Date: Tue, 11 Dec 2001 17:37:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, throughtput-only tests will have their numbers degradated with the
> > change applied on 2.4.16-pre2.
> > 
> > The whole thing is just about tradeoffs: Interactivity vs throughtput.
> > 
> > I'm not going to destroy interactivity for end users to get beatiful
> > dbench numbers.
>
> Latency is more of an issue for end user machines.

Time for CONFIG_OPTIMIZE_THROUGHPUT / CONFIG_OPTIMIZE_LATENCY ?

Dan

