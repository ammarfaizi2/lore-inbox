Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTKHWmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 17:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTKHWmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 17:42:05 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:40849 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262158AbTKHWmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 17:42:03 -0500
Message-ID: <3FAD7119.40804@cyberone.com.au>
Date: Sun, 09 Nov 2003 09:41:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
References: <200311090349.04983.kernel@kolivas.org>
In-Reply-To: <200311090349.04983.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>Hi
>
>I believe this is a simple typo / variable name mixup between rq_src and 
>this_rq. So far all testing shows positive (if minor) improvements.
>

Hi Con,
It was correct (as Ingo intended) before the patch, I think.



