Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265709AbSIRHY5>; Wed, 18 Sep 2002 03:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbSIRHY5>; Wed, 18 Sep 2002 03:24:57 -0400
Received: from denise.shiny.it ([194.20.232.1]:10191 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S265709AbSIRHY4>;
	Wed, 18 Sep 2002 03:24:56 -0400
Message-ID: <XFMail.20020918092952.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3D88208E.8545AAA2@kegel.com>
Date: Wed, 18 Sep 2002 09:29:52 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: RE: Hardware limits on numbers of threads?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18-Sep-2002 Dan Kegel wrote:
> http://people.redhat.com/drepper/glibcthreads.html says:
> 
>> Hardware restrictions put hard limits on the number of 
>> threads the kernel can support for each process. [...]

> Is this true?  Where does the limit come from?

Threads are a software thing. If you can have 2 threads, so
there is no limit, unless you want to make use of some
hardware facility I'm not aware of.

Bye.

