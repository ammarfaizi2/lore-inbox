Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSGLQFi>; Fri, 12 Jul 2002 12:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGLQFh>; Fri, 12 Jul 2002 12:05:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59909 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316601AbSGLQFg>; Fri, 12 Jul 2002 12:05:36 -0400
Subject: Re: Advice saught on math functions
To: kirk@braille.uwo.ca (Kirk Reiser)
Date: Fri, 12 Jul 2002 17:31:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <x7hej5djbj.fsf@speech.braille.uwo.ca> from "Kirk Reiser" at Jul 12, 2002 12:04:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T3KT-0003L4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > messages after PCI is initialised, until then they are queued away or
> > only on serial console.
> 
> Even though, pci gets initialized pretty early in the boot sequence
> doesn't it?  Considerably before init?

Yes. But quite a few crashes could occur before that (and have) - eg
running a K6 kernel on a 486
 
> accessibility yet.  I know for serial synths we can turn serial on in
> lilo and at least hear what is going on.  Without modifying lilo for
> each synth other than serial we have no way of knowing whether we have
> the full lilo prompt or what.

Serial is going away if the vendors get their way, maybe within 12 months
