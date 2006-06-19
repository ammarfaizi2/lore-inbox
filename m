Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWFSKQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWFSKQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWFSKQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:16:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2433 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932335AbWFSKQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:16:44 -0400
Subject: Re: About the fixes of /drivers/serial/8250.C in 2.6.17-rc6 for
	avoiding habbg-up
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: gouji <gouji.masayuki@jp.fujitsu.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060619093219.GA26941@flint.arm.linux.org.uk>
References: <000d01c6934c$f25c9870$f4647c0a@GOUJI>
	 <1150708994.2503.3.camel@localhost.localdomain>
	 <20060619093219.GA26941@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Jun 2006 11:31:42 +0100
Message-Id: <1150713102.2871.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-19 am 10:32 +0100, ysgrifennodd Russell King:
> > Yes, there is a bug in this version that was not in the one I submitted,
> > someone added an improvement.
> 
> I disagree - in the non-oops_in_progress case, your version and the
> merged version are 100% identical - see

So they are, sorry the one that differs was the original Red Hat
Enterprise Linux patch.

> I don't have the initial email from ysgrifennodd gouji, and neither
> do the lkml archives.  What's the problem?

Sysrq for one

