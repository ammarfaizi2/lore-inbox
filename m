Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288259AbSACQyj>; Thu, 3 Jan 2002 11:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSACQyf>; Thu, 3 Jan 2002 11:54:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:42255 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288259AbSACQxJ>;
	Thu, 3 Jan 2002 11:53:09 -0500
Date: Thu, 3 Jan 2002 14:52:52 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020103040924.B6936@thyrsus.com>
Message-ID: <Pine.LNX.4.33L.0201031452170.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Eric S. Raymond wrote:

> You have my intentions backwards. What I'd like to be able to do is
> suppress ISA_SLOTS when there are detectably *no* ISA cards.

So you want to make it impossible to compile kernels for
old machines on the new fast machine standing next to it ?

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

