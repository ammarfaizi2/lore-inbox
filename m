Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135483AbRDWP7d>; Mon, 23 Apr 2001 11:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135482AbRDWP7X>; Mon, 23 Apr 2001 11:59:23 -0400
Received: from [209.10.149.20] ([209.10.149.20]:38670 "EHLO mail.real.net")
	by vger.kernel.org with ESMTP id <S135484AbRDWP7L>;
	Mon, 23 Apr 2001 11:59:11 -0400
Message-ID: <3AE4512D.9030602@nyc.rr.com>
Date: Mon, 23 Apr 2001 11:58:37 -0400
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-pre6 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disappearing RAM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There appears to be quite a difference between the memory usage reported
by top
(immediately after boot and minus all user processes) and that reported
by the kernel
during boot.  Can anyone give me any hints as to why this might happen?

I am assuming that if I subtract all the memory in use by processes
listed by top from all
the memory in use that this equals the amount of memory used by the
kernel.
These numbers do not add up.

A related question:  In the 2.2 kernels, does the kernel pre-allocate
any amount of memory
for modules?

Or is everything I'm seeing related to VM bugs in 2.2.<19 ?

-- 
  -o) j o h n  e   w e b e r
  / \ aspiring computer scientist & lover of pengiuns
_\_v

