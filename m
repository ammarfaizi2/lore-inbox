Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311378AbSCSPJh>; Tue, 19 Mar 2002 10:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311379AbSCSPJ2>; Tue, 19 Mar 2002 10:09:28 -0500
Received: from relay1.pair.com ([209.68.1.20]:7173 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S311378AbSCSPJR>;
	Tue, 19 Mar 2002 10:09:17 -0500
X-pair-Authenticated: 68.5.32.62
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Nicolas.Turro@sophia.inria.fr (Nicolas Turro)
Subject: Re: amd nvidia and mem=nopentium
Date: Tue, 19 Mar 2002 07:11:22 -0800
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Nicolas.Turro@sophia.inria.fr (Nicolas Turro),
        linux-kernel@vger.kernel.org
In-Reply-To: <E16nL60-0007uF-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020319150920Z311378-889+124219@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd go Athlon
>
> >  Do you have pointers  showing stability problems when using
> > XP processor in a multiprocessor context ?
>
> Remember the XP's haven't been tested in MP configurations (or
> tested and failed). The same was true of celerons and as most
> people found the fail rate was pretty low 8)

You have to bridge L5-4 on the newest XP CPUs though.  My Tyan Tiger 
boards' BIOS was giving me something like-
00Error
  Failed

Turned out it needed those guys bridged up.  It's not that difficult 
though, I had a circuit pen lying about and just drew in a trace :).  
(You don't have to fill the cracks like the overclock bridges)

Anyway, it was pretty easy, but I wouldn't suggest it for the faint 
of heart.  Running 2.4.18 happily now in dual config with no 
stability problems.  I have compiled the kernel a few times, compiled 
Qt, all of KDE, xemacs, glibc, gcc, and a couple billion other things 
that I can't remember right now.  So, no stability problems with the 
newest XPs and a hand closed L5-4 bridge.  (So far anyway :) )

Thanks,
Shane Nay.
