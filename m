Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRE0BUP>; Sat, 26 May 2001 21:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbRE0BUF>; Sat, 26 May 2001 21:20:05 -0400
Received: from mail.alphalink.com.au ([203.24.205.7]:9996 "EHLO
	mail.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S262682AbRE0BTz>; Sat, 26 May 2001 21:19:55 -0400
Message-ID: <3B105882.4551E232@alphalink.com.au>
Date: Sun, 27 May 2001 11:29:38 +1000
From: Greg Banks <gnb@alphalink.com.au>
X-Mailer: Mozilla 4.07 [en] (X11; I; Linux 2.2.1 i586)
MIME-Version: 1.0
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
CC: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <20010525012200.A5259@thyrsus.com> <3B0F3268.A671BC7A@pocketpenguins.com> <002401c0e5aa$0049a000$47a6b3d0@Toshiba> <3B0F8042.90DD5C5D@pocketpenguins.com> <005801c0e614$b49a0120$44a6b3d0@Toshiba> <3B105492.5300778F@pocketpenguins.com> <018001c0e649$8111c380$52a6b3d0@Toshiba>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:
> 
> "Greg Banks" <gbanks@pocketpenguins.com> wrote:

  (I'm posting from a different address because kernel.org had
some difficulties with pocketpenguins.com)

> > Jaswinder Singh wrote:
> > >
> > > >
> > > BTW, how many WindowsCE machines are fully (means all the features as
> > > provided by Windows CE) supported by LinuxSH and how many machines are
> > > partially(only few features) supported by LinuxSH ?
> >
> >   I don't understand, what features do you mean?
> >
> 
> By features , i mean , that we can use all the hardware of WindowsCE machine
> , like Touch panel , modem , IrDA, Sound , etc , etc .

  Modems are tricky, because they're frequently WinModems which
have a whole lot of well-known issues.  Other features depend on
the speed at which they can be reverse engineered, as most
WinCE manufacturers don't co-operate.  I'd be surprised if any
WindowsCE machine's hardware was fully supported by LinuxSH yet,
but I don't have a full list anywhere (sorry).  I'd guess the HP
Jornada 600 series are probably best supported.

Greg.
-- 
If it's a choice between being a paranoid, hyper-suspicious global
village idiot, or a gullible, mega-trusting sheep, I don't look
good in mint sauce.                      - jd, slashdot, 11Feb2000.
