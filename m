Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWDEMKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWDEMKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 08:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWDEMKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 08:10:21 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:6283 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751228AbWDEMKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 08:10:21 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200604051206.k35C6Uiq009761@wildsau.enemy.org>
Subject: Re: Q on audit, audit-syscall
In-Reply-To: <20060405114112.GA24452@lnx-holt.americas.sgi.com>
To: Robin Holt <holt@sgi.com>
Date: Wed, 5 Apr 2006 14:06:30 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 05, 2006 at 01:27:03PM +0200, Herbert Rosmanith wrote:
> > 
> > good afternoon,
> > 
> > I'm searching for a way to trace/intercept syscalls, both before and
> > after execution. "ptrace" is not an option (you probably know why).
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^

> Does strace do what you are asking for?

as I said, "ptrace" is not an option.

