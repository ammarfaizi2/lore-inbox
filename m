Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTJRNSS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 09:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTJRNSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 09:18:18 -0400
Received: from dyn-ctb-210-9-245-184.webone.com.au ([210.9.245.184]:49932 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261605AbTJRNSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 09:18:17 -0400
Message-ID: <3F913D97.4030507@cyberone.com.au>
Date: Sat, 18 Oct 2003 23:18:15 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v16
References: <3F913704.5040707@cyberone.com.au>
In-Reply-To: <3F913704.5040707@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> Hi
>
> http://www.kerneltrap.org/~npiggin/v16/
>
> I'm starting to do some large SMP / NUMA testing. Fixed and changed quite
> a bit. It isn't too bad, although I'm only testing dbench, tbench, and
> volanomark at the moment.
>

Oh, if anyone can suggest other benchmarks I could use it would be good
(I'm currently getting osdl's dbt2 set up). System is 16-way 16GB ia32
NUMA and very minimum disk bandwidth. Thanks.


