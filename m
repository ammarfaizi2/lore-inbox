Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVAGQlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVAGQlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVAGQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:40:31 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:17815 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261507AbVAGQjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:39:23 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 7 Jan 2005 08:39:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501070837410.17078@bigblue.dev.mdolabs.com>
References: <41DE9D10.B33ED5E4@tv-sign.ru> <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Linus Torvalds wrote:

> I'm clearly enamoured with this concept. I think it's one of those few 
> "RightThing(tm)" that doesn't come along all that often. I don't know of 
> anybody else doing this, and I think it's both useful and clever. If you 
> now prove me wrong, I'll hate you forever ;)

I don't know which kind of poison Larry put in your glass when you two 
met, but it clearly worked :=)



- Davide

