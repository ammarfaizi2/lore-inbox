Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSBMXRj>; Wed, 13 Feb 2002 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSBMXRT>; Wed, 13 Feb 2002 18:17:19 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:16909 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289098AbSBMXRE>; Wed, 13 Feb 2002 18:17:04 -0500
Date: Thu, 14 Feb 2002 00:16:57 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.5-pre1
Message-ID: <20020213231656.GA24236@merlin.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Linus Torvalds wrote:

> This is a _huge_ patch, mainly because it includes three big pending
> things: the ALSA merge [...]

Regression test: Does that ALSA stuff that's just been merged support
16bit I/O on Creative Labs Sound Blaster Vibra 16X (DSP 4.xx, those with
the two 8-bit-DMA channels rather than the usual 1 8-bit and 1 16-bit
DMA channel as found on other ISA sound blaster cards)?

AFAIK, ALSA 0.9 supported this, 0.5 did not, so take this question as
"what version is that ALSA stuff that's been merged?" if you like.
