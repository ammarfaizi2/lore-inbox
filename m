Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311683AbSCNRHr>; Thu, 14 Mar 2002 12:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311684AbSCNRHh>; Thu, 14 Mar 2002 12:07:37 -0500
Received: from dialin-145-254-145-175.arcor-ip.net ([145.254.145.175]:18670
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id <S311683AbSCNRH1>; Thu, 14 Mar 2002 12:07:27 -0500
Message-ID: <3C9066F3.F1FFCDA2@pcsystems.de>
Date: Thu, 14 Mar 2002 10:01:39 +0100
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: Doug McNaught <doug@wireboard.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: memory/cpu handling problem ? (x86)
In-Reply-To: <3C0EA220.D943FAF6@pcsystems.de> <m3pu5tckui.fsf@belphigor.mcnaught.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:

> Nico Schottelius <nicos@pcsystems.de> writes:
>
> > Hello Folks!
> >
> > A small ansi C program which tries to get all cpu power and as much ram
> > as possible got my system.
>
> $ man setrlimit

thanks for the answer!
I just thought  linux could handle itself a process which tries to gain all
cpu power.
Using setrlimit I can setup maximum cpu time seconds, but not maximum use of
cpu
at a time, can't I ?


--
Nico Schottelius

Sorry for delayed messages. The backlog is getting smaller!
It's less then 50 mails currently!

Please send your messages pgp-signed or pgp-encrypted.
If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)



