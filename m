Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbSA2V5L>; Tue, 29 Jan 2002 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbSA2V5B>; Tue, 29 Jan 2002 16:57:01 -0500
Received: from ns.suse.de ([213.95.15.193]:43787 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281916AbSA2V4u>;
	Tue, 29 Jan 2002 16:56:50 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain.suse.lists.linux.kernel> <E16VYD8-0003ta-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Jan 2002 22:56:49 +0100
In-Reply-To: Alan Cox's message of "29 Jan 2002 14:14:30 +0100"
Message-ID: <p73aduwddni.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > If a patch gets ignored 33 times in a row then perhaps the person doing
> > the patch should first think really hard about the following 4 issues:
> 
> Lots of the stuff getting missed is tiny little fixes, obvious 3 or 4 liners.
> The big stuff is not the problem most times. That stuff does get ripped to

"Most times". For example the EA patches have badly failed so far, just because
Linus ignored all patches to add sys call numbers for a repeatedly discussed 
and stable API and nobody else can add syscall numbers on i386. 

-Andi
