Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289532AbSBNCar>; Wed, 13 Feb 2002 21:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289487AbSBNCah>; Wed, 13 Feb 2002 21:30:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289455AbSBNCaa>;
	Wed, 13 Feb 2002 21:30:30 -0500
Message-ID: <3C6B2144.1986141F@mandrakesoft.com>
Date: Wed, 13 Feb 2002 21:30:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.5-pre1
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <20020213231656.GA24236@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> 
> On Wed, 13 Feb 2002, Linus Torvalds wrote:
> 
> > This is a _huge_ patch, mainly because it includes three big pending
> > things: the ALSA merge [...]
> 
> Regression test: Does that ALSA stuff that's just been merged support
> 16bit I/O on Creative Labs Sound Blaster Vibra 16X (DSP 4.xx, those with
> the two 8-bit-DMA channels rather than the usual 1 8-bit and 1 16-bit
> DMA channel as found on other ISA sound blaster cards)?

Doesn't matter 1) The OSS drivers are still all there

Doesn't matter 2) We finally have a sound maintainer who can respond to
this... with code!  :)

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
