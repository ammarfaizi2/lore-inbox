Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTLJR1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTLJR1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:27:10 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:30656 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263824AbTLJR0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:26:14 -0500
Message-ID: <3FD75711.3060103@nortelnetworks.com>
Date: Wed, 10 Dec 2003 12:25:37 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org> <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com> <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com> <Pine.LNX.4.58.0312100852210.29676@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> But also note how it's only the BINARY MODULE that is a derived work. Your
> source code is _not_ necessarily a derived work, and if you compile it for
> another operating system, I'd clearly not complain.
> 
> This is the "stand-alone short story" vs "extra chapter without meaning
> outside the book" argument. See? One is a work in its own right, the other
> isn't.

We currently have a situation where an external company supplies us with 
a device driver containing a binary blob that was explicitly written as 
OS-agnostic, and a shim that is gpl'd (at least the linux shim is) to 
get the appropriate os-specific services.  I guess this would fall under 
the "not made just for linux" category in which you've placed the Nvidia 
driver?

Carrying on your analogy, this could be a generic love scene, with 
blanks in which to insert the character's names and location.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

