Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTJQWNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTJQWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:13:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:27286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbTJQWNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:13:46 -0400
Date: Fri, 17 Oct 2003 15:13:43 -0700
From: cliff white <cliffw@osdl.org>
To: "M. Fioretti" <m.fioretti@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RULE Tinderbox clients for the kernel
Message-Id: <20031017151343.2361995d.cliffw@osdl.org>
In-Reply-To: <20031017202422.GM4943@inwind.it>
References: <20031017202422.GM4943@inwind.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 22:24:22 +0200
"M. Fioretti" <m.fioretti@inwind.it> wrote:

[ snip ] 
> 
> > Either way, please send me your desired .config - i can and should 
> > build a size test into the tinderclient code. 
> 
> Er.... this is the sad note. I am pretty good in userland, but much
> more ignorant here. What I can tell is which kind of boxes would be
> used and how, but translating that to the proper .config requires the
> help of you gurus. We will gratefully test whatever you ask and
> report, within our bandwidth and CPU power limits, but this is why I
> sent my original message to the LKML.
> 
> We need to use boxes with i386 or greater, 16+ MB RAM, disk space from
> 3/400 MB upwards in basically two ways (depending from the end user
> needs and the actual hw available)
> 
> low load servers for modern printing (cups) firewall (iptables) email,
> web
> 
> desktop with kdrive and functional, yet not bloated applications for
> school and soho use worldwide. This means, feature wise:
> 
> digital signature with GPG
> email, spreadsheet, word processing (abiword, gnumeric)
> web browsing (flash? maybe, not essential)
> non ASCII alphabets
> something else which I will certainly remember one picosecond after
> hitting the send button...
> 

Okay, i will try a few samples and send the result direct to you.
cliffw

> 
> -- 
> Marco Fioretti                 m.fioretti, at the server inwind.it
> Red Hat for low memory         http://www.rule-project.org/en/
> 
> Don't think that a small group of dedicated individuals can't change
> the world. it's the only thing that ever has.  (read on /.)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
