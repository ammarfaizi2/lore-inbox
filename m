Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSBZXau>; Tue, 26 Feb 2002 18:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSBZXak>; Tue, 26 Feb 2002 18:30:40 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:26858 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288019AbSBZXa1>; Tue, 26 Feb 2002 18:30:27 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: low latency & preemtible kernels
Date: Wed, 27 Feb 2002 00:30:12 +0100
X-Mailer: KMail [version 1.3.9]
Cc: wwp <subscript@free.fr>, Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200202261918.53190.Dieter.Nuetzel@hamburg.de> <20020226235510.E6197@werewolf.able.es>
In-Reply-To: <20020226235510.E6197@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200202270030.12347.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 26. Februar 2002 23:55:23, J.A. Magallon wrote:
> On 20020226 Dieter Nützel wrote:
> >wwp wrote:
> >> Hi there,
> >>
> >> here's a newbie question:
> >> is it UNadvisable to apply both preempt-kernel-rml and low-latency
> >> patches over a 2.4.18 kernel?
> >
> >In short: no ;-)
> >
> >Try 2.4.18-rc4-jam2 for example. It should apply against 2.4.18 final,
> > too.
>
> Correction: jam2 is O(1)-multi-queue scheduler + low-latency, no
> preeemt there.

I put it on top as always...;-)

Did that before all by hand, now you have set the starting point.

Regards,
	Dieter
BTW I will use 2.4.18-jam1.
