Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUBLLYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266396AbUBLLYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:24:38 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:57316 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266395AbUBLLYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:24:37 -0500
Message-ID: <402B6251.2060909@cyberone.com.au>
Date: Thu, 12 Feb 2004 22:24:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Christine Moore <cem@osdl.org>
Subject: Re: 2.6.3-rc2-mm1
References: <20040212015710.3b0dee67.akpm@osdl.org>
In-Reply-To: <20040212015710.3b0dee67.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/
>
>

Nether this nor the previous one boots on the NUMAQ at osdl.
Not sure which is the last -mm that did. 2.6.3-rc2 boots.

I turned early_printk on and nothing. It stops at
Loading linux..............

