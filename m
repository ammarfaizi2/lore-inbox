Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbTCICTc>; Sat, 8 Mar 2003 21:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbTCICTc>; Sat, 8 Mar 2003 21:19:32 -0500
Received: from bitmover.com ([192.132.92.2]:38285 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262363AbTCICTb>;
	Sat, 8 Mar 2003 21:19:31 -0500
Date: Sat, 8 Mar 2003 18:30:07 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030309023007.GE15187@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com> <20030307233916.Q17492@flint.arm.linux.org.uk> <m1d6l2lih9.fsf@frodo.biederman.org> <20030308100359.A27153@flint.arm.linux.org.uk> <m18yvpluw7.fsf@frodo.biederman.org> <20030308161309.B1896@flint.arm.linux.org.uk> <m1vfytkbsk.fsf@frodo.biederman.org> <3E6A5BC2.6040808@zytor.com> <m1isutjmye.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1isutjmye.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree the size of glibc 1.1M and /bin/bash 600K are substantial.
> And in most cases if I had to drop one it would be /bin/bash.  But 2M
> is not that bad if you already need 14M for your modules.   

[...]

> My basic point was it sounds like the development process is backwards.
> It feels like we are starting big and then going small, instead of the
> other way around.  

Truer words were never spoken.  Less is more.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
