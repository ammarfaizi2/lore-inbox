Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVFWXL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVFWXL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVFWXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:11:26 -0400
Received: from main.uucpssh.org ([212.27.33.224]:38329 "EHLO main.uucpssh.org")
	by vger.kernel.org with ESMTP id S262280AbVFWXKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:10:11 -0400
To: dipankar@in.ibm.com
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, bero@arklinux.org, rjw@sisk.pl,
       sharyath@in.ibm.com
Subject: Re: 2.6.12-mm1: BUG() in fd_install, RCU related?
References: <20050621083424.GA2076@elf.ucw.cz>
	<20050621090721.GA7976@in.ibm.com>
	<874qbpwbae.873br9wbae@871x6twbae.message.id>
	<20050623190218.GA4999@in.ibm.com>
From: syrius.ml@no-log.org
Message-ID: <87r7esu159.87psucu159@87oe9wu159.message.id>
Date: Fri, 24 Jun 2005 01:05:49 +0200
In-Reply-To: <20050623190218.GA4999@in.ibm.com> (Dipankar Sarma's message of "Fri, 24 Jun 2005 00:32:18 +0530")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> writes:

> [...]
> Aha, this has been extremely helpful. Could you all please try the
> following (untested) patch ? This should fix the problem, or
> atleast one problem that I can see.

glad that it helped.
and actually it does fix the problem i was having.
Thank you !

-- 
