Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbUK3XSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUK3XSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUK3XK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:10:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:8357 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262420AbUK3XGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:06:50 -0500
Date: Tue, 30 Nov 2004 15:05:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mariusz Mazur <mmazur@kernel.pl>
cc: Alexandre Oliva <aoliva@redhat.com>, David Howells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <200411302352.51849.mmazur@kernel.pl>
Message-ID: <Pine.LNX.4.58.0411301503470.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
 <200411302352.51849.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Mariusz Mazur wrote:
> 
> Userland? And who's using vanilla kernel headers in userland? Duplicates 
> maintainers can always fix stuff independent of kernel (and I do).

Dammit, how hard is it for people to admit that they aren't the only ones 
around?

There are still people who use ancient setups, and upgrade the kernel. 
They won't complain to _you_ or to redhat when their setup breaks, because 
they aren't _using_ your setup. They complain to me.

This is what statisticians call "self-selection". It means that you guys 
only see the part of the world that uses your stuff, so you think that 
there is nothing else. 

> I don't get your point.

Very obviously. 

		Linus
