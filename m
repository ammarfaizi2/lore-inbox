Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUCCXJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUCCXJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:09:35 -0500
Received: from web14526.mail.yahoo.com ([216.136.224.55]:39357 "HELO
	web14526.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261241AbUCCXJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:09:33 -0500
Message-ID: <20040303230932.38072.qmail@web14526.mail.yahoo.com>
Date: Wed, 3 Mar 2004 15:09:32 -0800 (PST)
From: Ankur Prakash <ankurp77@yahoo.com>
Subject: Compilation issue with sched_yield().
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am using sched_yield() on a RedHat 9.0 system. I get

the following compilation error. Anyone has any clues?
I am compiling with -lpthread.

Thanks,
Ankur

: undefined reference to `pthread_yield_np'


__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
