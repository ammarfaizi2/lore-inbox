Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268000AbTBRUcx>; Tue, 18 Feb 2003 15:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268001AbTBRUcx>; Tue, 18 Feb 2003 15:32:53 -0500
Received: from main.gmane.org ([80.91.224.249]:33752 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S268000AbTBRUcw>;
	Tue, 18 Feb 2003 15:32:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Wuertele <dave-gnus@bfnet.com>
Subject: Re: how to interactively break gdb debugging kernel over serial?
Date: Tue, 18 Feb 2003 12:37:29 -0800
Organization: Berkeley Fluent Network
Message-ID: <m38ywd72ba.fsf@bfnet.com>
References: <20030214234557.GC13336@doc.pdx.osdl.net> <m38ywia054.fsf@bfnet.com>
 <3E4F3A40.3090502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2 (i686-pc-linux-gnu)
Cancel-Lock: sha1:vXhHcgRjdbO7LaaKarVNjYvOqGk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm debugging the kernel with gdb over a serial port.  Breakpoints and
>> stepping through code works great, except for the fact that once the
>> kernel is running, I can't seem to use Control-C to stop it.  Is there
>> a keypress or other interactive way to break a running kernel?
>> Thanks,
>> Dave

george> There are a great number of kgdb patches in the wild.  You
george> would help us out a lot if you were to name the one you are
george> using.

Here's the output from gdb --version:

GNU gdb Red Hat Linux (5.1.90CVS-5)
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux".

Does that help?

Thanks,
Dave

