Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266431AbUAIHwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 02:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266432AbUAIHwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 02:52:25 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:15515 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266431AbUAIHwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 02:52:24 -0500
Date: Thu, 8 Jan 2004 23:52:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, reiser@namesys.com,
       joe@perches.com, green@linuxhacker.ru, mfedyk@matchmail.com,
       torvalds@osdl.org, tim@cambrant.com, markhe@nextd.demon.co.uk,
       manfred@colorfullife.com, matthew@wil.cx
Subject: Re: Cleanup patches - comparison is always [true|false] +
 unsigned/signed compare, and similar issues.   (consolidating existing
 threads)
Message-Id: <20040108235219.5d77f34b.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.56.0401081847190.10083@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401081847190.10083@jju_lnx.backbone.dif.dk>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The key question in my view was what code was easiest to understand.
This is closest to being the code that is shortest, stripped of all
non-essential detail.  But not exactly.  Code is more like novel or
essay in my view, than a poem.  I don't find haiku clear.  However,
what is easiest to understand is a judgement call.

Since we were seeing here, with the remarks of folks such as myself,
a nice example of that well known phenomenon where a committee will
debate for hours over the $25 budget line item, and then pass the
$3 million item without comment, your conclusion to try using the
Trivial Patch Monkey sounds like a winner.  Rusty has good judgement,
and for changes such as this, better one good judge making immediate
decisions, than lengthy lkml threads.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
