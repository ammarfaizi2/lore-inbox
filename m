Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266858AbUGLOii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266858AbUGLOii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUGLOii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:38:38 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:4736 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S266858AbUGLOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:38:37 -0400
Date: Mon, 12 Jul 2004 06:38:35 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ issues, (nobody cared, disabled), not USB
Message-ID: <20040712143835.GA2113@iarc.uaf.edu>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040708155356.GG22065@iarc.uaf.edu> <20040708220522.73839ea3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708220522.73839ea3.akpm@osdl.org>
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [2004-Jul-08 21:05 AKDT]:
> Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
> > For the past few iterations of 2.6 (including the vanilla 2.6.7 I'm 
> > running now) I've had this problem:
> > 
> >  03:27:26 kernel: irq 7: nobody cared!
> 
> It would be useful if you could go back to 2.6.5 for a while, so we can
> mostly-eliminate a hardware glitch.

2.6.5 lasted three days.  Same error as before.  I'm back to 2.6.7, 
trying the kernel parameters suggested by Len Brown ("acpi_irq_balance" 
plus "acpi_isa_irq=7").

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (work)
Intl. Arctic Research Center            cswingle@gmail.com (personal)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

