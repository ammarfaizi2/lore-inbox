Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263521AbUJ2UeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbUJ2UeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbUJ2U3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:29:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42501 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263521AbUJ2UYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:24:11 -0400
Date: Fri, 29 Oct 2004 22:21:53 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       typo@shaw.ca, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paulo Marques <pmarques@grupopie.com>
Subject: Re: Linuxant/Conexant HSF/HCF Modem Drivers Unlocked
Message-ID: <20041029202153.GM19761@alpha.home.local>
References: <1099032721.23148.5.camel@localhost> <418226FA.1030803@grupopie.com> <1099053788.4511.13.camel@localhost> <1099057814.13068.29.camel@localhost.localdomain> <20041029200011.GA18508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029200011.GA18508@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 09:00:12PM +0100, Dave Jones wrote:
> On Fri, Oct 29, 2004 at 02:50:42PM +0100, Alan Cox wrote:
>  > On Gwe, 2004-10-29 at 13:43, Chad Christopher Giffin wrote:
>  > > I still find myself deeply troubled and questioning the legalities of
>  > > using "GPL\0[...]" in the license string of a non-GPL module.  As it is
>  > > a blatant lie.  
>  > 
>  > Oh its almost certainly a criminal offence in the USA - the DMCA for
>  > example. The \0 stupidity checker needs to go into the kernel.
> 
> Copy protection arms-races are always fun. If we did this, no doubt
> some enterprising individual would find that some other value
> also has the same effect.  You need to throw out anything else
> thats non alphanumeric too.  (plus '/' for 'Dual BSD/GPL' and friends)

Use Pascal-like strings then. I see no way to fake them.

Willy

