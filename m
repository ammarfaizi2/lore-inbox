Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTJIERQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 00:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTJIERQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 00:17:16 -0400
Received: from dyn-ctb-210-9-246-216.webone.com.au ([210.9.246.216]:5638 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261895AbTJIERN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 00:17:13 -0400
Message-ID: <3F84E12F.3050101@cyberone.com.au>
Date: Thu, 09 Oct 2003 14:16:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Orlov <bugfixer@list.ru>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2-6.0-test6-mm4: badness in get_io_context
References: <20031009040508.GA917@nikolas.hn.org>
In-Reply-To: <20031009040508.GA917@nikolas.hn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Orlov wrote:

>Andrew,
>
>Please find attached snippet from kernel log file. Basically, assert
>was raised when machine was shutting down as a part of the reboot.
>
>If it matters: I have nVidia kernel module loaded. 
>
>Most likely I wouldn't be able to reproduce it because it happened only 
>once out of about 10 reboots.
>
>Kernel version is 2.6.0-test6-mm4 and all packages are updated on daily
>basis from Debian/unstable. Kernel config file is also attached
>to this letter.
>
>Please feel free to contact me with any questions you might have.
>
>

These are probably false positives from my debug code. Just ignore them 
unless
they are happening a lot.


