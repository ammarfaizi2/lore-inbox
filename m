Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312989AbSC0LMa>; Wed, 27 Mar 2002 06:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSC0LMT>; Wed, 27 Mar 2002 06:12:19 -0500
Received: from www.wen-online.de ([212.223.88.39]:15634 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S312550AbSC0LMI>;
	Wed, 27 Mar 2002 06:12:08 -0500
Date: Wed, 27 Mar 2002 12:24:19 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: stas.orel@mailcity.com
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Anyone else seen VM related oops on 2.4.18?
In-Reply-To: <3CA197B9.2070502@yahoo.com>
Message-ID: <Pine.LNX.4.10.10203271222230.8985-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Stas Sergeev wrote:

> Hello.
> 
> Arjan Opmeer wrote:
> > Are there other people that are suffering from a VM related oops on kernel 
> > 2.4.18?
> Yes:(
> I've seen that oops 24/7 after installing a
> new video card Radeon 7500 AGP.
> Before I had PCI video card.
> When DRI is enabled, the whole box hangs after
> ~10 minutes of using OpenGL, and if DRI disabled
> and radeon.o is unloaded, I have a vm-related Oopses.

You can use dri with your 7500?  Same processor as 8500 cards?
If so, which X sources are you using?

I bought an 8500 Evil Master II specifically because I saw Radeon
support in the kernel and X source.  Much to my chagrin, I can't
use dri because the source (4.2.0) says dri is not yet implimented
for that processor.

	-Mike

