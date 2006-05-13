Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWEMLz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWEMLz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWEMLz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:55:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:39560 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932396AbWEMLz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:55:28 -0400
X-Authenticated: #14349625
Subject: Re: rt20 scheduling latency testcase and failure data
From: Mike Galbraith <efault@gmx.de>
To: Florian Paul Schmidt <mista.tapas@gmx.net>
Cc: Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060513112039.41536fb5@mango.fruits>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <20060513112039.41536fb5@mango.fruits>
Content-Type: text/plain
Date: Sat, 13 May 2006 13:55:38 +0200
Message-Id: <1147521338.7909.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 11:20 +0200, Florian Paul Schmidt wrote:

> P.S.: I ran the test a few [20 or so] times and didn't get any failures
> of the sort you see. Even with a 1ms period:

Something odd happened here... the first time I booted rt21, I could
reproduce the problem quite regularly.  Since reboot though, poof.

Elves and Gremlins.

	-Mike

