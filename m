Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268021AbUIKBqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268021AbUIKBqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 21:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUIKBqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 21:46:42 -0400
Received: from [66.35.79.110] ([66.35.79.110]:28038 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S268021AbUIKBpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 21:45:53 -0400
Date: Fri, 10 Sep 2004 18:45:43 -0700
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@ximian.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040911014543.GA5053@hockin.org>
References: <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <20040911001849.GA321@hockin.org> <20040911004827.GA8139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911004827.GA8139@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 05:48:27PM -0700, Greg KH wrote:
> need be.  This keeps the kernel interface much simpler, and doesn't
> allow you to abuse it for things it is not intended for (like error
> reporting stuff...)

Errm, not for error reporting?  So the "driver hardening" and fault
logging people shouldn't use this?

