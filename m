Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVLFCYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVLFCYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVLFCYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:24:09 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:50839 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S964928AbVLFCYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:24:08 -0500
Message-Id: <200512060110.jB61AMHF004027@pincoya.inf.utfsm.cl>
To: Florian Weimer <fw@deneb.enyo.de>
cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Florian Weimer <fw@deneb.enyo.de> 
   of "Mon, 05 Dec 2005 21:33:06 BST." <87hd9n708t.fsf@mid.deneb.enyo.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 05 Dec 2005 22:10:22 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:

[...]

> You mentioned security issues in your initial post.  I think it would
> help immensely if security bugs would be documented properly (affected
> versions, configuration requirements, attack range, loss type etc.)
> when the bug is fixed, by someone who is familiar with the code.
> (Currently, this information is scraped together mostly by security
> folks, sometimes after considerable time has passed.)  Having a
> central repository with this kind of information would enable vendors
> and not-quite-vendors (people who have their own set of kernels for
> their machines) to address more vulnerabilties promptly, including
> less critical ones.

I've fixed bugs which turned out to be security vulnerabilities. And I
didn't know (or even care much) at the time. Finding out if some random bug
has security implications, and exactly which ones/how much of a risk they
pose is normally /much/ harder than to fix the bugs.  And rather pointless,
after the fix is in.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
