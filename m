Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263260AbSJFDKC>; Sat, 5 Oct 2002 23:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263264AbSJFDKC>; Sat, 5 Oct 2002 23:10:02 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:17165 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S263260AbSJFDKB>;
	Sat, 5 Oct 2002 23:10:01 -0400
Date: Sat, 5 Oct 2002 21:03:08 -0600
From: Mazhar Memon <mazhar@nmt.edu>
To: law@dodinc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bizarre network issue
Message-Id: <20021005210308.07d381ff.mazhar@nmt.edu>
In-Reply-To: <3D9F7169.8020008@dodinc.com>
References: <3D9F7169.8020008@dodinc.com>
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Greetings.....
> 
> I am working on a driver for generic serial-based radios (e.g, Coyote 
> Datacomm
> DR-915 and Microhard MHX-910, etc..), that basically allows the radio to 
> be used
> as a network interface, much in the spirit of STRIP.  Kernel is 2.4.8 
> (mandrake 8.1).

Are you willing share your code? I'd love to see what you have so far since I have a similar project.  It is basically using a wireless link that supposed to look like a terminal.  I'm hoping that all I'll need to do is make a simple driver to implement hard_start_xmit and let pppd do the rest.  Probably like your radio, it has a 0-7 network id which I assume you are including in your MAC addr some how.

Regards,
Mazhar
