Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268255AbTCCBzC>; Sun, 2 Mar 2003 20:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268272AbTCCBzC>; Sun, 2 Mar 2003 20:55:02 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:26767 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268255AbTCCBzB>; Sun, 2 Mar 2003 20:55:01 -0500
Date: Mon, 03 Mar 2003 15:08:11 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
In-reply-to: <20030303003940.GA13036@k3.hellgate.ch>
To: Roger Luethi <rl@hellgate.ch>
Cc: bert hubert <ahu@ds9a.nl>, Pavel Machek <pavel@ucw.cz>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046657290.8668.33.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030226211347.GA14903@elf.ucw.cz>
 <20030302133138.GA27031@outpost.ds9a.nl>
 <1046630641.3610.13.camel@laptop-linux.cunninghams>
 <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 13:39, Roger Luethi wrote:
> I'm seeing the bug every time I try swsuspend on 2.5. The same Vanilla
> kernels seem to work for other people, though.

Yes - I have no problems in this area.

> The only thing that came up at the time was a suggestion to replace BUG_ON
> with while (which I didn't try because I'd like to keep my data).

I'll see if I can find a solution.

Regards,

Nigel

