Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRDWVMl>; Mon, 23 Apr 2001 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbRDWVMW>; Mon, 23 Apr 2001 17:12:22 -0400
Received: from cnxt10143.conexant.com ([198.62.10.143]:38412 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131990AbRDWVMK>; Mon, 23 Apr 2001 17:12:10 -0400
Date: Mon, 23 Apr 2001 23:11:51 +0200 (CEST)
From: <rui.sousa@mindspeed.com>
X-X-Sender: <rsousa@localhost.localdomain>
To: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [OFFTOPIC] Re: ioctl arg passing
In-Reply-To: <m3wv8bl5dj.fsf@shookay.e-steel.com>
Message-ID: <Pine.LNX.4.33.0104232310090.1417-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 2001, Mathieu Chouquet-Stringer wrote:

> <rui.sousa@mindspeed.com> writes:
>
> > On Mon, 23 Apr 2001, Ingo Oeser wrote:
> >
> > > On Mon, Apr 23, 2001 at 05:06:48PM +0100, Matt wrote:
> > > > I'm writing a char device driver for a dsp card that drives a motion
> > > > platform.
> > >
> > > Can you elaborate on the dsp card? Is it freely programmable? I'm
> > > working on a project to support this kind of stuff via a
> > > dedicated subsystem for Linux.
> >
> > Very interesting... The emu10k1 driver (SBLive!) that will appear
> > shortly in acXX will support loading code to it's DSP. It's a very
> > simple chip with only 16 instructions but it can generate
> > hardware interrupts, DMA to host memory, 32 bit math. The maximum
> > program size is 512 instructions (64 bits each) and can make use of 256
> > registers (32 bits).
>
> Do you mean we will be able to have the same kind of stuff they have on
> Windows

If someone writes the dsp code...

> (like the mp3 encoding computed by the SB Live)??

This in particular seems to be a myth...

Rui Sousa

