Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTJQUYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTJQUYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 16:24:30 -0400
Received: from smtp2.libero.it ([193.70.192.52]:43985 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S263623AbTJQUY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 16:24:26 -0400
Date: Fri, 17 Oct 2003 22:24:22 +0200
From: "M. Fioretti" <m.fioretti@inwind.it>
To: cliff white <cliffw@osdl.org>
Cc: m.fioretti@inwind.it, linux-kernel@vger.kernel.org
Subject: RULE Tinderbox clients for the kernel
Message-ID: <20031017202422.GM4943@inwind.it>
Reply-To: "M. Fioretti" <m.fioretti@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PREMISE: I am sending this to the RULE mailing list too (bcc so no
bounces arrive to kernel users unsubscribed there). Any kernel guy
interested in this is very welcome to subscribe temporarily also to
the low volume RULE mailing list. TIA

On Tue, Oct 14, 2003 15:56:38 at 03:56:38PM -0700, cliff white (cliffw@osdl.org) wrote:

> We (OSDL + others) are working on a continuous build/test system,
> using the Mozilla tinderbox.  Should be available RSN. Tinderbox
> supports multiple clients, and we'll have a client package available
> for download.
> 
> Marco, if you could supply time on a small client box, and a desired
> .config, we can add you as a Tinderbox client, then you have a place
> to point people when the size increases.

I am forwarding this excellent idea to the RULE list. I hope that
someone there has the bandwidth and spare hardware to do it.
Thanks a thousand.

> Either way, please send me your desired .config - i can and should 
> build a size test into the tinderclient code. 

Er.... this is the sad note. I am pretty good in userland, but much
more ignorant here. What I can tell is which kind of boxes would be
used and how, but translating that to the proper .config requires the
help of you gurus. We will gratefully test whatever you ask and
report, within our bandwidth and CPU power limits, but this is why I
sent my original message to the LKML.

We need to use boxes with i386 or greater, 16+ MB RAM, disk space from
3/400 MB upwards in basically two ways (depending from the end user
needs and the actual hw available)

low load servers for modern printing (cups) firewall (iptables) email,
web

desktop with kdrive and functional, yet not bloated applications for
school and soho use worldwide. This means, feature wise:

digital signature with GPG
email, spreadsheet, word processing (abiword, gnumeric)
web browsing (flash? maybe, not essential)
non ASCII alphabets
something else which I will certainly remember one picosecond after
hitting the send button...


-- 
Marco Fioretti                 m.fioretti, at the server inwind.it
Red Hat for low memory         http://www.rule-project.org/en/

Don't think that a small group of dedicated individuals can't change
the world. it's the only thing that ever has.  (read on /.)
