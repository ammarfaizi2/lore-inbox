Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284629AbRLETx0>; Wed, 5 Dec 2001 14:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284628AbRLETxR>; Wed, 5 Dec 2001 14:53:17 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:12283 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S284624AbRLETw5>; Wed, 5 Dec 2001 14:52:57 -0500
Message-ID: <019401c17dc5$2e946130$0801a8c0@Stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>,
        "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0112051917430.3021-100000@mustard.heime.net>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
Date: Wed, 5 Dec 2001 19:43:57 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Basically you cannot simply expect an increase in readahead size to
> > increase performance:
> >
> > 1) The files you created may not be sequential
>
> Beleive me - they are! Created with 'dd' secuentially

thats still does not mean they are sequential creating
large files almost always causes them to fragment.

Actually does anyone know of an easy way to find out
if certin files are fragmented and by how much ?




