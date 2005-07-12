Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVGLWCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVGLWCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVGLWCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:02:04 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:11960 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262414AbVGLWB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:01:57 -0400
Message-ID: <42D43DC6.70004@namesys.com>
Date: Tue, 12 Jul 2005 15:01:42 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Keenan Pepper <keenanpepper@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt + reiser4?
References: <42D4201A.9050303@gmail.com> <1121198723.10580.10.camel@mindpipe>
In-Reply-To: <1121198723.10580.10.camel@mindpipe>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Tue, 2005-07-12 at 15:55 -0400, Keenan Pepper wrote:
>  
>
>>Ingo Molnar's realtime-preempt patches used to be based on the -mm 
>>kernels, but now they appear to be based on the mainline kernels, so 
>>they don't support reiser4 (at least until reiser4 is merged into 
>>mainline, which is looking uncertain as I understand it).
>>    
>>
>
>It's not uncertain, the reiser4 people just have to address the issues
>that were raised on LKML before it will be merged, just like everyone
>else.
>  
>
Maybe tomorrow the changes will compile.....  they have been written.....
