Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDKHjU>; Wed, 11 Apr 2001 03:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRDKHjJ>; Wed, 11 Apr 2001 03:39:09 -0400
Received: from t2.redhat.com ([199.183.24.243]:1784 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S131344AbRDKHjD>; Wed, 11 Apr 2001 03:39:03 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix 
In-Reply-To: Your message of "Tue, 10 Apr 2001 12:42:07 PDT."
             <Pine.LNX.4.31.0104101229150.13071-100000@penguin.transmeta.com> 
Date: Wed, 11 Apr 2001 08:38:57 +0100
Message-ID: <13054.986974737@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can CONFIG_X86_XADD be equated to CONFIG_X86_CMPXCHG?

David
