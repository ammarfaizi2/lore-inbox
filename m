Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTDPRrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTDPRrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:47:22 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:45045 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S264491AbTDPRrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:47:21 -0400
Date: Wed, 16 Apr 2003 20:10:44 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Dave Mehler <dmehler26@woh.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rh9 and 2.5 kernel difficulties
Message-ID: <20030416181044.GE30098@wind.cocodriloo.com>
References: <003b01c3043c$0876ad10$0200a8c0@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003b01c3043c$0876ad10$0200a8c0@satellite>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 01:17:17PM -0400, Dave Mehler wrote:
> Hello,
>     I've successfully compiled/installed a 2.5.67 kernel on rh9, and the
> modules. The problem is when i boot it grub just hangs, i'm assuming i've
> compiled everything right, i've read about the keyboard/mouse/monitor
> issues, but then i got a reference to something to do with modules and
> compatibility with 2.4, I did not however find this and i'm wondering if
> that is my problem. Can anyone give me a pointer to all that i need for
> this? My system has an A7A266 motherboard, and i'm getting an error about
> i8253 count too high! error message and it was suggested that a 2.5 kernel
> would resolve this.
>         Thanks.
> Dave.

I've also just installed rh9 and I'm compiling a 2.5.66 kernel right now,
so we may share experiences. This will my desktop machine, all important
stuff is done on another one but I'll try my kernel patches on it.

To avoid module-related problems and easier booting, I've left everything
I need compiled inline and turned off modules. I'm net-booting, so I'm
also compiling NFS-root and in-kernel DHCP autoconfig just in case I
need it later on.

Will keep the list informed about progress.

Greets, Antonio.

ps. what are the keyboard/mouse/monitor issues???
