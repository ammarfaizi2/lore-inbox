Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268444AbTBNNxn>; Fri, 14 Feb 2003 08:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268447AbTBNNxn>; Fri, 14 Feb 2003 08:53:43 -0500
Received: from nile.gnat.com ([205.232.38.5]:38558 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S268444AbTBNNxm>;
	Fri, 14 Feb 2003 08:53:42 -0500
To: firefly@diku.dk, tjm@codegen.com
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       peter@jazz-1.trumpet.com.au
Message-Id: <20030214140336.501F2F2D7B@nile.gnat.com>
Date: Fri, 14 Feb 2003 09:03:36 -0500 (EST)
From: dewar@gnat.com (Robert Dewar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The only way to get from long-mode back to legacy-mode is to reset the
> > processor.  It can be done in software but you will likely lose interrupts.
> 
> Smartdrv.sys and triple-faults come back, all is forgiven!  ;)

I have an idea, perhaps we can make the keyboard controller recognize a special
command that will reset the processor :-) :-)
