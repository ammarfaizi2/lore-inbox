Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTJVMvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 08:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTJVMvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 08:51:40 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:12687 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263311AbTJVMvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 08:51:39 -0400
Message-ID: <3F967D66.9090601@cyberone.com.au>
Date: Wed, 22 Oct 2003 22:51:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Badness in as_completed_request at drivers/block/as-iosched.c:919
References: <20031022123209.GA2652@linuxhacker.ru>
In-Reply-To: <20031022123209.GA2652@linuxhacker.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oleg Drokin wrote:

>Hello!
>
>

Hi Oleg,
The warning should be harmless. I'll remove it once I make sure. I
don't think there have been any recent as-iosched changes, so something
else must have just triggered it off.
Thanks.


