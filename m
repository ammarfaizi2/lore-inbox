Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282841AbRK0Hwf>; Tue, 27 Nov 2001 02:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282844AbRK0HwZ>; Tue, 27 Nov 2001 02:52:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:54282 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282841AbRK0HwN>;
	Tue, 27 Nov 2001 02:52:13 -0500
Date: Tue, 27 Nov 2001 05:51:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <editors@newsforge.com>,
        <lwn@lwn.net>
Subject: Re: Linux 2.4.16
In-Reply-To: <20011127083530.A13584@bee.lk>
Message-ID: <Pine.LNX.4.33L.0111270551210.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Anuradha Ratnaweera wrote:
> On Mon, Nov 26, 2001 at 10:30:08AM -0200, Marcelo Tosatti wrote:
> >
> > final:
> > - Fix 8139too oops				(Philipp Matthias Hahn)
>
> Won't that be a good idea to keep the -final the same as the last -pre?

That's basically what happened. This 8139too fix is
ONE LINE, in a self-contained piece of code.

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

