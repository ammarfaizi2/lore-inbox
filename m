Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVHaWo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVHaWo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVHaWo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:44:27 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:27300 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932541AbVHaWo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:44:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: daniel mclellan <daniel.mclellan@gmail.com>
Subject: Re: [ck] 2.6.13-ck1
Date: Thu, 1 Sep 2005 08:47:36 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck list <ck@vds.kolivas.org>
References: <200508291703.26529.kernel@kolivas.org> <20050831194958.GA7021@spherenet.spherevision.org> <200508311507.10801.daniel.mclellan@gmail.com>
In-Reply-To: <200508311507.10801.daniel.mclellan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509010847.36930.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005 06:07 am, daniel mclellan wrote:
> Yes.
>
>
> Linux yavanna 2.6.13-ckx1 #1 Tue Aug 30 04:03:25 EST 2005 x86_64 AMD
> Athlon(tm) 64 FX-53 Processor AuthenticAMD GNU/Linux
>
> On Wednesday 31 August 2005 14:49, Rodney Gordon II wrote:
> > On Mon, Aug 29, 2005 at 05:03:24PM +1000, Con Kolivas wrote:
> > > These are patches designed to improve system responsiveness and
> > > interactivity. It is configurable to any workload but the default ck*
> > > patch is aimed at the desktop and ck*-server is available with more
> > > emphasis on serverspace.
> > >
> > >
> > > Apply to 2.6.13
> > > http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1.bz
> > >2 or development version:
> > > http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1+.b
> > >z2
> > >
> > > or server version:
> > > http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1-se
> > >rv er.bz2
> >
> > I am having odd lockup problems with just the non-+ 'stable' ck lately..
> > Trying a large copy will often lock my disk I/O up and I have to do a
> > hard reboot. Nothing shows in logs..
> >
> > Is anyone having similar problems?

2 things:

What HZ are you running?
Can you set up netconsole or serial console as these will capture something 
that won't be seen in your logs.

Cheers,
Con
