Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291929AbSBATnb>; Fri, 1 Feb 2002 14:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291926AbSBATnV>; Fri, 1 Feb 2002 14:43:21 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:13758 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S291935AbSBATnM>; Fri, 1 Feb 2002 14:43:12 -0500
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Message-Id: <200202011943.UAA04625@faui02b.informatik.uni-erlangen.de>
Subject: Re: [PATCH] Q40 input api support.
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 1 Feb 2002 20:43:04 +0100 (MET)
Cc: jsimmons@transvirtual.com (James Simmons), linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020201165538.A17286@suse.cz> from "Vojtech Pavlik" at Feb 01, 2002 04:55:38 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > +static inline void q40kbd_write(unsigned char val)
> > > +{
> > > +	/* FIXME! We need a way how to write to the keyboard! */
> > > +}
> > 
> > absolutely no way to write to the keyboard.
> 
> Really? Too bad. So no way to set LEDs, no way to detect the keyboard,
> no way to set it to "Scancode Set 3"?

no way to control LED's, keyboard is assumed present, scancode set 
is AT

Richard

