Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSLJTOZ>; Tue, 10 Dec 2002 14:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSLJTOZ>; Tue, 10 Dec 2002 14:14:25 -0500
Received: from intpop.corp.wcom.ca ([205.150.160.74]:12695 "EHLO corp.wcom.ca")
	by vger.kernel.org with ESMTP id <S265369AbSLJTOY> convert rfc822-to-8bit;
	Tue, 10 Dec 2002 14:14:24 -0500
Message-ID: <046801c2a081$6f4a4980$9c094d8e@wcom.ca>
From: "Serge Kuznetsov" <serge@wcom.ca>
To: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20021208030851.GB12907@conectiva.com.br> <03c201c29fac$e7737510$9c094d8e@wcom.ca> <20021209181110.GT17067@conectiva.com.br>
Subject: Re: [PATCH] ipv4/route: convert /proc/net/rt_cache to seq_file
Date: Tue, 10 Dec 2002 14:22:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > BTW: Is /proc/net/arp has been fixed?
> 
> Yes, I have submitted some changesets fixing problems with /proc/net/arp
> seq_file handling. Please let me know if you find any problems.

Yes. It working fine now. I mean for kernel 2.5.51.


All the Best!
Serge.
