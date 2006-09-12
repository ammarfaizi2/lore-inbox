Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWILXP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWILXP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 19:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWILXP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 19:15:29 -0400
Received: from xenotime.net ([66.160.160.81]:4299 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932356AbWILXP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 19:15:28 -0400
Date: Tue, 12 Sep 2006 16:16:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Victor Hugo <victor@vhugo.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] e-mail clients
Message-Id: <20060912161636.9f7e7139.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0609120906540.6283@yvahk01.tjqt.qr>
References: <1158031971.5057@shark.he.net>
	<Pine.LNX.4.61.0609120906540.6283@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006 09:08:37 +0200 (MEST) Jan Engelhardt wrote:

> >
> >pine (but make sure that it doesn't truncate trailing whitespace)
> 
> Truncating whitespace at EOL is a good thing. Otherwise, quilt says
> 
> Warning: trailing whitespace in lines 237,364 of 
> net/ipv4/netfilter/regexp/regexp.c
> Warning: trailing whitespace in line 57 of 
> net/ipv4/netfilter/regexp/regsub.c
> Warning: trailing whitespace in lines 307,308,309 of 
> net/ipv4/netfilter/ipt_layer7.c

Of course.  But there were/are versions of pine that truncate
whitespace "for you," even if such truncation is not desired,
independent of quilt et al.  So one wouldn't want to use that
"feature" for kernel patches.


> for example. Long lines are usually not broken up if pasted verbatim as this example line will show for sure abc.
> 
> pine wraps text only when typing (at least that's how I configured
> mine), so it is all safe.

---
~Randy
