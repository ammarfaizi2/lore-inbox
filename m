Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266414AbUAOCmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbUAOCmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:42:09 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:43410 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266414AbUAOCk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:40:26 -0500
Message-ID: <4005FD76.4030800@cyberone.com.au>
Date: Thu, 15 Jan 2004 13:39:50 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm3
References: <20040114014846.78e1a31b.akpm@osdl.org>
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm3/
>
>
>- A big ppc64 update from Anton
>
>- Added Nick's CPU scheduler patches for hyperthreaded/SMT CPUs.  This work
>  needs lots of testing and review from those who care about and work upon
>  this feature, please.
>

This also includes my SMP / NUMA scheduler work, so it should help
larger SMP and especially NUMA systems. Testing would be good.


