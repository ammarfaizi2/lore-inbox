Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUI1JSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUI1JSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 05:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUI1JSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 05:18:42 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:8541 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266316AbUI1JSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 05:18:40 -0400
Message-ID: <41592C64.3030409@yahoo.com.au>
Date: Tue, 28 Sep 2004 19:18:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Ed Schouten <edschouten@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] i386: Xbox support
References: <65184.217.121.83.210.1096308147.squirrel@217.121.83.210> <4158AA5B.8090601@yahoo.com.au> <dc54396f040927214651393131@mail.gmail.com> <415915F0.2000803@yahoo.com.au> <20040928090641.GC18819@elf.ucw.cz>
In-Reply-To: <20040928090641.GC18819@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>Well, I ask because there is probably quite a large number of embedded type
>>devices devices that you could "just add a small patch for" to get it 
>>working.
> 
> 
> Yes, and we support most of them :-). This is not really different
> from all the arm platforms etc.


Yeah OK. I don't want to turn this into an argument, but the difference
is AFAIK, that many of them are made *for* running Linux (or at least as
a supported configuration). While the xbox requires you to circumvent
the hardware.

But on the other hand, "why not?" :)

As I said, so long as Linus or Andrew is happy with it, I don't care.
