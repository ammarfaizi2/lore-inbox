Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318245AbSGQH6j>; Wed, 17 Jul 2002 03:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318243AbSGQH6i>; Wed, 17 Jul 2002 03:58:38 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:21810 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S318241AbSGQH6g>; Wed, 17 Jul 2002 03:58:36 -0400
Date: Wed, 17 Jul 2002 18:04:48 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Ali5451 and MIDI synth
In-Reply-To: <1026896364.1688.127.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.05.10207171759430.2212-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 2002, Alan Cox wrote:

> On Wed, 2002-07-17 at 03:51, Neale Banks wrote:
> > * linux-2.2 has MIDI support in the code (v0.14.5c of trident.c) - but
> > this driver (a) doesn't work for basic audio[1] and (b) doesn't register a
> > MIDI synth device (and MIDI players complain of no device).
> 
> ALSA supports the synth facilities of the device, but not as "midi". The
> trident synth doesn't talk midi.

Pardon the naive question, but does that mean that apps looking for
(IIRC) /dev/sequencer are going to be workable with this chip or not?

If yes, what do I need to read up on?

Thanks,
Neale.

