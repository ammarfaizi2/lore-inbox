Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUA3Kjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 05:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUA3Kjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 05:39:52 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:41489 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262050AbUA3Kju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 05:39:50 -0500
Message-ID: <401A3762.5070701@aitel.hist.no>
Date: Fri, 30 Jan 2004 11:52:18 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
References: <20040130014108.09c964fd.akpm@osdl.org>
In-Reply-To: <20040130014108.09c964fd.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm2/
> 
> 
> - I added a few late-arriving patches.  Usually this breaks things.
> 
Indeed, it didn't apply:
patching file include/linux/sched.h
Reversed (or previously applied) patch detected!  Assume -R? [n] N
Apply anyway? [n] N

I unpacked 2.6.0 and patched it up to 2.6.2-rc2 again to be sure.
Everything else applied so I'm compiling that now.

Helge Hafting


