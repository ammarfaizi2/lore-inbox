Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTIPWw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 18:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTIPWw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 18:52:27 -0400
Received: from web41808.mail.yahoo.com ([66.218.93.142]:28863 "HELO
	web41808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262562AbTIPWw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 18:52:26 -0400
Message-ID: <20030916225225.75843.qmail@web41808.mail.yahoo.com>
Date: Tue, 16 Sep 2003 15:52:25 -0700 (PDT)
From: M M <mokomull@yahoo.com>
Subject: Re: Kernel 2.6.0-test5 Refuses to Boot (ceases after "mice: PS/2 mouse device common for all mice")
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030915193657.483fd953.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling APCI works.  Thanks.

-MrM

--- Andrew Morton <akpm@osdl.org> wrote:
> M M <mokomull@yahoo.com> wrote:
> >
> > I've downloaded, configured (make oldconfig using
> > .config from 2.4.21), and compiled kernel
> > 2.6.0-test5,
> > but it just refuses to boot completely.
> Also try disabling ACPI.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
