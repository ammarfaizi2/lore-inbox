Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTGKOSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbTGKOQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:16:32 -0400
Received: from angband.namesys.com ([212.16.7.85]:50059 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261944AbTGKOOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:14:33 -0400
Date: Fri, 11 Jul 2003 18:29:15 +0400
From: Oleg Drokin <green@namesys.com>
To: Peter Lojkin <ia6432@inbox.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs problem (not boot)
Message-ID: <20030711142914.GB24682@namesys.com>
References: <E19ayZE-000Ipt-00.ia6432-inbox-ru@f12.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19ayZE-000Ipt-00.ia6432-inbox-ru@f12.mail.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jul 11, 2003 at 06:08:08PM +0400, "Peter Lojkin"  wrote:

> After few hours of work with 2.4.22-pre3 (patched to solve mount problem) we got this (ksyms was unavailable):

There was one more reiserfs message in kernel log just before this line, can you please include it?

> Jul 10 06:25:41 host kernel: kernel BUG at prints.c:334!
> Jul 10 06:25:41 host kernel: invalid operand: 0000
> Jul 10 06:25:41 host kernel: CPU:    1
> Jul 10 06:25:41 host kernel: EIP:    0010:[reiserfs_panic+41/96]    Not tainted

Bye,
    Oleg
