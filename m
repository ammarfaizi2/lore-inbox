Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTDXS5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTDXS5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:57:34 -0400
Received: from watch.techsource.com ([209.208.48.130]:51451 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S262174AbTDXS5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:57:33 -0400
Message-ID: <3EA83A59.40201@techsource.com>
Date: Thu, 24 Apr 2003 15:26:17 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange behavior in out-of-memory situation
References: <3EA83396.4040904@techsource.com> <20030424190248.GA2766@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:

>  
>
>
>The only unusual here is that ctrl+c didn't work, but some
>programs block that signal. Perhaps your program does too.
>  
>

I wrote the program, and it's a simple data processor.  It does nothing 
to block ctrl-c.  In fact, although I couldn't run ps, top, or vmstat, I 
could run other things like ls and vi.


