Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264392AbRFNBps>; Wed, 13 Jun 2001 21:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264393AbRFNBpi>; Wed, 13 Jun 2001 21:45:38 -0400
Received: from [64.56.164.18] ([64.56.164.18]:16135 "EHLO www.vgkk.com")
	by vger.kernel.org with ESMTP id <S264392AbRFNBp3>;
	Wed, 13 Jun 2001 21:45:29 -0400
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: obsolete code must die
Date: Thu, 14 Jun 2001 10:45:10 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGCEFCEEAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010614013224.0E3A278599@mail.clouddancer.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that removing support for any hardware is a bad idea but I question
the idea of putting it all in one monolithic download (tar file). If we're
considering the concern for less developed nations with older hardware,
imagine how you would like to download the whole kernel with an old 2400 bps
modem. Not a fun thought.

Would it make sense to create some sort of 'make config' script that
determines what you want in your kernel and then downloads only those
components? After all, with the constant release of new hardware, isn't a
50MB kernel release not too far away? 100MB?


--Rainer

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Colonel
> Sent: Thursday, June 14, 2001 10:32 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: obsolete code must die
>
>
> In list.kernel, you wrote:
>
> >i think we are all missing the ball here: i am happy when i see driver
> >support for a piece of hardware that i have _NEVER_ heard of and at most
> >_ONE_ person uses it.  why?  it means more stuff works in linux.  we
> >dont need to defend how many people use hardware X.  if you have X, good
> >for you.  if not, you dont care, but at least good for linux as a whole.
>
> Good Point!
>
> >lets stop fanning the flames and let this (Microsoft-using, as Rik
> >pointed out) troll die off.
>
> Agreed, he made the filter already.  But it was good for some laughs,
> checking a few cobwebs and I really didn't see flames.  Plus I got to
> test my new mailing list archive.

