Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288266AbSACRCt>; Thu, 3 Jan 2002 12:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSACRCk>; Thu, 3 Jan 2002 12:02:40 -0500
Received: from ns.suse.de ([213.95.15.193]:6404 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287289AbSACRC2>;
	Thu, 3 Jan 2002 12:02:28 -0500
Date: Thu, 3 Jan 2002 18:01:31 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33L.0201031452170.24031-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0201031800480.7309-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Rik van Riel wrote:

> > You have my intentions backwards. What I'd like to be able to do is
> > suppress ISA_SLOTS when there are detectably *no* ISA cards.
> So you want to make it impossible to compile kernels for
> old machines on the new fast machine standing next to it ?

I assumed ESR proposed a 'configure for this box' button,
not the default case.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

