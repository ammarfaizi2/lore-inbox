Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbTATCI0>; Sun, 19 Jan 2003 21:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbTATCI0>; Sun, 19 Jan 2003 21:08:26 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:26496 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S267748AbTATCIZ>;
	Sun, 19 Jan 2003 21:08:25 -0500
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15915.22671.867328.281811@charged.uio.no>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	 <15915.21051.365166.964932@charged.uio.no>
	 <1043027422.668.4.camel@tux.rsn.bth.se>
	 <15915.22671.867328.281811@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043029046.668.6.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 03:17:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 03:01, Trond Myklebust wrote:
> >>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:
> 
>      > # ls portmap/clnteb2bbc7c -l
>      > ls: portmap/clnteb2bbc7c/info: No such file or directory total
>      > 0
> 
> OK. Try this...

Ohh, now it works, or at least it starts. It doesn't complain about
anything now.

And it actually works, I tried mounting an exported directory on another
machine and it works!

This is with all 5 patches you sent, I just applied them as I got them.
If you want I can try with just a few of them, just tell me which you
want me to test.

Thank you _very_ much for the rapid help.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
