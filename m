Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286997AbRL1TYB>; Fri, 28 Dec 2001 14:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286993AbRL1TXw>; Fri, 28 Dec 2001 14:23:52 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:16827 "EHLO
	uni-koblenz.de") by vger.kernel.org with ESMTP id <S286990AbRL1TXk>;
	Fri, 28 Dec 2001 14:23:40 -0500
Date: Fri, 28 Dec 2001 14:26:14 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
        Amber Palekar <amber_palekar@yahoo.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Again:syscall from modules
Message-ID: <20011228142614.A1915@dea.linux-mips.net>
In-Reply-To: <20011225131441.60811.qmail@web20306.mail.yahoo.com> <1009468465.15846.0.camel@eggis1> <15403.28458.153083.961800@charged.uio.no> <20011228134106.B1323@dea.linux-mips.net> <15404.37994.476173.804713@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15404.37994.476173.804713@charged.uio.no>; from trond.myklebust@fys.uio.no on Fri, Dec 28, 2001 at 04:48:58PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 04:48:58PM +0100, Trond Myklebust wrote:

>      > Many sys_*() functions may be in the generic code but that
>      > still doesn't mean the ports are actually using it or that no
>      > special calling sequence which normally would be done in libc
>      > is required.  Only people doing syscalls themselfes and not
>      > through libc wrappers is worse ...
> 
> Please read the beginning of the thread. The question was about
> calling from within kernel space. No libc is or can be involved...

I was just comparing ...

  Ralf
