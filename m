Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbTGHTz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTGHTzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:55:14 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:12783 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265297AbTGHTzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:55:08 -0400
Date: Wed, 09 Jul 2003 08:09:49 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Tainted: S
In-reply-to: <20030708195325.GA2673@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1057694989.14496.20.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057692128.14471.10.camel@laptop-linux>
 <20030708195325.GA2673@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah ok. How about 'Z' then? (As in zzzzz).

Regards,

Nigel

On Wed, 2003-07-09 at 07:53, Dave Jones wrote:
> On Wed, Jul 09, 2003 at 07:22:08AM +1200, Nigel Cunningham wrote:
>  > With the latest prepatch for the 2.4 version of swsusp, I've made swsusp
>  > taint the kernel upon resume from a suspend-to-disk. Any oopses that
>  > occur afterwards will contain S as a third character (eg PFS).
>  
> 2.5 already uses 'S' to mark "out-of-spec SMP system".
> 
> 		Dave
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.
> www.parasoft.com/bulletproofapps
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

