Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWIZVjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWIZVjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWIZVjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:39:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:30611 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964834AbWIZVjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:39:01 -0400
Message-ID: <45199DF3.1050708@garzik.org>
Date: Tue, 26 Sep 2006 17:38:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       PC300 Maintainer <pc300@cyclades.com>
Subject: Re: Generic HDLC update
References: <m3odt21hs5.fsf@defiant.localdomain> <m3ac4m1fbj.fsf@defiant.localdomain>
In-Reply-To: <m3ac4m1fbj.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> The first patch renames drivers/net/wan/hdlc_generic.c file to hdlc.c.
> It has been generated with git-diff* -M. Please let me know if you
> need a "normal" patch.

It depends completely on what git-applymbox will accept, and how 
git-applymbox interprets your submission.

In this case... testing... it looks like it renamed things correctly.

	Jeff


