Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288169AbSACDjl>; Wed, 2 Jan 2002 22:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288175AbSACDjc>; Wed, 2 Jan 2002 22:39:32 -0500
Received: from ns.suse.de ([213.95.15.193]:23058 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288173AbSACDjY>;
	Wed, 2 Jan 2002 22:39:24 -0500
Date: Thu, 3 Jan 2002 04:39:23 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102221845.A27252@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201030435450.6449-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> > Go down the DMI path, and get it right _sometimes_, or take a zero.
> > Getting it right sometimes is likely to do more harm than good.
> Not in this case.  If the DMI read fails, the worst-case result is the
> user sees some ISA extra questions.

Erm, worse case would surely be "I have ISA cards, and all the options
to use them are missing". Sure you could have a button to switch them
all back on, but hey! this implies Aunt Tillie knows she has ISA cards
which gets everything right back to square one.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

