Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272407AbRIVWKx>; Sat, 22 Sep 2001 18:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272413AbRIVWKn>; Sat, 22 Sep 2001 18:10:43 -0400
Received: from fep01-svc.mail.telepac.pt ([194.65.5.200]:23967 "EHLO
	fep01-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S272407AbRIVWKf>; Sat, 22 Sep 2001 18:10:35 -0400
Message-ID: <3BAD0B7A.2000306@yahoo.com>
Date: Sat, 22 Sep 2001 23:06:50 +0100
From: Paulo da Silva <psdasilva@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 performance issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I used to listen mp3 files, using mpg123 -b 2048 -z (nice -15, for ex. -
sometimes I forget this!), without any interruption, even with
an relatively overloaded system! This was one
of my arguments when advertising Linux performance.

Now I'm getting, from times to times, some interruptions,
without any relevant workload.
I have noticed that when this happens, the kswapd task is allways
on the top of "top" program, CPU sorted.

I'm not sure at what kernel this began to happen, since I am
changing the recent kernels (2.4.x) at the same rate they are
released. Currently I'm using 2.4.9.

If you need any further information, please email me, because
I'm not sure what info is pertinent for an eventual analisys.
I'm also able to perform any test you may find useful even
to change and recompile the sources.

Best regards,
Paulo da Silva


