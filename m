Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266911AbRGYLIy>; Wed, 25 Jul 2001 07:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266919AbRGYLIo>; Wed, 25 Jul 2001 07:08:44 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:15364 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266911AbRGYLIe>; Wed, 25 Jul 2001 07:08:34 -0400
Message-ID: <3B5EA8F8.D8C0EDE7@t-online.de>
Date: Wed, 25 Jul 2001 13:09:44 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Nico Schottelius <nicos@pcsystems.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ps2/ new data for mouse protocol (fwd msg attached)
In-Reply-To: <3B5DB12D.2B9C205E@pcsystems.de> <20010725012334.L23404@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Erik Mouw wrote:
> 
> On Tue, Jul 24, 2001 at 07:32:29PM +0200, Nico Schottelius wrote:
> > Have a look into the attached email before reading mine, please.
> >
> > Is it possible to find out about what those bytes are ?
> > And is it possible to intergrate the support for other
> > 3 bytes into the Linux kernel ?
> 
> So they put information about four buttons in six bytes and call that
> proprietary? ROFL! How hard can it be? I think it will be fairly
> straight forward to reverse engineer the format, it can't be rocket
> science.

No need for this, just read the public available documentation !

Proprietary != Secret.

However, some mouse secrets from various sources I hacked in here: http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c
