Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317408AbSGOJzA>; Mon, 15 Jul 2002 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317409AbSGOJy7>; Mon, 15 Jul 2002 05:54:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54847 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317408AbSGOJy6>; Mon, 15 Jul 2002 05:54:58 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kirk@braille.uwo.ca (Kirk Reiser), linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
References: <E17T3KT-0003L4-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jul 2002 03:46:12 -0600
In-Reply-To: <E17T3KT-0003L4-00@the-village.bc.nu>
Message-ID: <m1ele5pbmj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > messages after PCI is initialised, until then they are queued away or
> > > only on serial console.
> > 
> > Even though, pci gets initialized pretty early in the boot sequence
> > doesn't it?  Considerably before init?
> 
> Yes. But quite a few crashes could occur before that (and have) - eg
> running a K6 kernel on a 486
>  
> > accessibility yet.  I know for serial synths we can turn serial on in
> > lilo and at least hear what is going on.  Without modifying lilo for
> > each synth other than serial we have no way of knowing whether we have
> > the full lilo prompt or what.
> 
> Serial is going away if the vendors get their way, maybe within 12 months

Well except for the debug port specification, which appears to be just
another name for a serial port.

Eric
