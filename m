Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTJRFaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 01:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTJRFaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 01:30:23 -0400
Received: from dyn-ctb-210-9-245-184.webone.com.au ([210.9.245.184]:35847 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261345AbTJRFaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 01:30:22 -0400
Message-ID: <3F90CFE5.5000801@cyberone.com.au>
Date: Sat, 18 Oct 2003 15:30:13 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
References: <200310180018.21818.rob@landley.net>
In-Reply-To: <200310180018.21818.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob Landley wrote:

>I just rewrote bunzip2 for busybox in about 500 lines of C (and a good chunk 
>of that's comments), which comiles to a bit under 7k, and I was thinking of 
>redoing the bunzip-the-kernel patch with my new bunzip code, but I can't find 
>the patch.  Anybody got a URL to it?
>
>The most recent one I could find was kerneltrap's 404-error link to 
>http://chrissicool.piranho.com/patch-2.4.x-bzip2-i386
>


This came up on the list a while back. IIRC the conclusion was that
runtime memory usage and speed, and not so significant compression
improvement over gzip.


