Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVLIWT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVLIWT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVLIWT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:19:28 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:9518 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932456AbVLIWT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:19:28 -0500
Date: Fri, 9 Dec 2005 22:19:19 +0000 (GMT)
From: Ken Moffat <ken@linuxfromscratch.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Ken Moffat <zarniwhoop@ntlworld.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
In-Reply-To: <1134164403.18432.33.camel@mindpipe>
Message-ID: <Pine.LNX.4.63.0512092210430.24505@deepthought.mydomain>
References: <1134154208.14363.8.camel@mindpipe> 
 <Pine.LNX.4.63.0512091930440.19998@deepthought.mydomain> 
 <1134158342.18432.1.camel@mindpipe>  <Pine.LNX.4.63.0512092121080.23848@deepthought.mydomain>
 <1134164403.18432.33.camel@mindpipe>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-290252875-1134166390=:24505"
Content-ID: <Pine.LNX.4.63.0512092217240.24602@deepthought.mydomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-290252875-1134166390=:24505
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.63.0512092217241.24602@deepthought.mydomain>

On Fri, 9 Dec 2005, Lee Revell wrote:

>
> It seems like CROSS_COMPILE= should not be needed if my standard gcc
> binary can produce x86-64 code.  I was hoping it would be possible to
> build an x86-64 kernel using the Ubuntu packages and that I would not
> have to resort to building my own toolchain.  And it seems that it's
> supposed to work, but doesn't.
>
  Last time I used it, crosstool was painless, but I guess you'd prefer 
this link to x86 cross-compilers that akpm posted the other month: 
http://developer.osdl.org/dev/plm/cross_compile/

(I haven't tried the x86_64 version there, but the powerpc64 worked a 
treat).

-- 
  das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-290252875-1134166390=:24505--
