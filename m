Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267040AbRGSHmG>; Thu, 19 Jul 2001 03:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267046AbRGSHl4>; Thu, 19 Jul 2001 03:41:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:26351 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S267040AbRGSHlk>; Thu, 19 Jul 2001 03:41:40 -0400
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read/write semaphore trylock routines - 2.4.6 
In-Reply-To: Message from "Brian J. Watson" <Brian.J.Watson@compaq.com> 
   of "Wed, 18 Jul 2001 16:22:56 PDT." <3B561A50.A1B35FBC@compaq.com> 
Date: Thu, 19 Jul 2001 08:41:43 +0100
Message-ID: <2297.995528503@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is this patch ready to go into the kernel? Is there anything else I
> should do to get it ready? I noticed it didn't make it into
> 2.4.7-pre7.

It looks reasonable, though I haven't tried it myself (I presume you have
though). You might want to try sending it direct to Linus.

David
