Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319112AbSHFOqp>; Tue, 6 Aug 2002 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHFOqp>; Tue, 6 Aug 2002 10:46:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26888 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S319112AbSHFOqm>; Tue, 6 Aug 2002 10:46:42 -0400
Date: Tue, 6 Aug 2002 10:59:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy TARREAU <willy@w.ods.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] APM fix for 2.4.20pre1
In-Reply-To: <1028650029.18156.174.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208061059410.7342-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 Aug 2002, Alan Cox wrote:

> On Tue, 2002-08-06 at 14:43, Willy TARREAU wrote:
> > Hi Marcelo,
> >
> > I resend you this patch against 2.4.19-rc5 which prevents my SMP box from
> > randomly crashing at boot during APM initialization. It still applies to
> > 2.4.20-pre1. Alan included it in 19-ac4 too. Basically, it forces bios
> > calls to be made only from CPU0.
>
> Doing the job right is a bit more complex than that. Thanks to your hint
> I've actually got APM SMP working a lot better on multiple boxes now.
> Marcelo - I may send you some cooler stuff but this one should be
> applied anyway

Its already applied.

