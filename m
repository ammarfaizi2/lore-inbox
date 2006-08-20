Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWHTWVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWHTWVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWHTWVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:21:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25483 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751651AbWHTWVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:21:09 -0400
Subject: Re: GPL Violation?
From: Arjan van de Ven <arjan@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Patrick McFarland <diablod3@gmail.com>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060820220538.GA10011@opteron.random>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
	 <200608170242.40969.diablod3@gmail.com>
	 <1155807431.22871.157.camel@pmac.infradead.org>
	 <20060820220538.GA10011@opteron.random>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 21 Aug 2006 00:20:44 +0200
Message-Id: <1156112444.23756.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> My only worry is what's the legal status of the vsyscall if the only
> thing that matters is the COPYING file and not its generally agreed
> interpretation.
> -

I've yet to see a generally agreed interpretation on any kind of
exception to the COPYING file (afaik there is none), and if there's no
exception..... I don't think there's a generally agreed interpretation
on when exactly something becomes a derived work either. That is where
lawyers come in, and I suspect that it will even vary from country to
country to some degree, depending on the fine details on exactly how and
what you do. And since I'm not a lawyer, all I can say is: if you want
to live your life on that particular edge, make sure you talk to a good
lawyer or two (and most will give you the advice to really try hard to
not live on that edge, precisely because it's so unclear and varying on
jurisdiction) . Anything else you or I say on this topic is sort of
meaningless since neither of us are lawyers. 

On the vsyscall page... I thought it was BSD licensed, and if not, it
probably should be, and I agree with you that that probably wants to be
made explicit somewhere if it's not already.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

