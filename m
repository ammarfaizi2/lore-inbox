Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUK0RVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUK0RVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUK0RVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:21:44 -0500
Received: from mail.linicks.net ([217.204.244.146]:27396 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261285AbUK0RV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:21:28 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd0 oops -> debug information
Date: Sat, 27 Nov 2004 17:21:21 +0000
User-Agent: KMail/1.7
References: <200411271311.25997.nick@linicks.net> <41A8B2EF.5090608@osdl.org>
In-Reply-To: <41A8B2EF.5090608@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411271721.21847.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 November 2004 17:01, Randy.Dunlap wrote:

> kernel version?

Heh.  My great debug attempt, eh?

kernel 2.6.9

> .config file?
> full oops message, with stack backtrace?
> The stack backtrace could tell us who a bad caller is.
> It can just be a caller's problem, not a bug in (this)
> one isolated function.

http://linicks.net/kdebug/

> Did you read/check linux/REPORTING-BUGS ?

Yes, but wanted to try and learn myself on what was going on, rather than push 
the onus onto other people.

The book I have re the make /dir/file.s states that it will produce assembler 
with _line_ numbers to corresponding C code.  That is where I got lost, as it 
doesn't.

Thanks,

Nick.

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
