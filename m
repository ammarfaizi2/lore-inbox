Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSHMPV6>; Tue, 13 Aug 2002 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSHMPV6>; Tue, 13 Aug 2002 11:21:58 -0400
Received: from imail.ricis.com ([64.244.234.16]:6917 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S315503AbSHMPV5>;
	Tue, 13 Aug 2002 11:21:57 -0400
Date: Tue, 13 Aug 2002 10:39:42 -0500
From: Lee Leahu <lee@ricis.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel crashes with 2.4.17
Message-Id: <20020813103942.2f8feb21.lee@ricis.com>
In-Reply-To: <Pine.NEB.4.44.0208131711020.14606-100000@mimas.fachschaften.tu-muenchen.de>
References: <20020813084358.7e8de7d3.lee@ricis.com>
	<Pine.NEB.4.44.0208131711020.14606-100000@mimas.fachschaften.tu-muenchen.de>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.  I just upgraded the kernel to 2.4.19.

I noticed that this problem bagan *after* I enabled the kernel nfs server.

I have been running the new kernel for over a 1/2 hour and have seen no problems so far.  
The 2.4.17 kernel would have thrown errors by now.

Adrian Bunk <bunk@fs.tum.de> scribbled something about Re: kernel crashes with 2.4.17:

> On Tue, 13 Aug 2002, Lee Leahu wrote:
> 
> > I am running the Linux Kernel 2.4.17.
> >
> > >From what I have put here, what can you tell might be the problem?
> >...
> > Aug 13 06:40:40 list kernel: Oops: 0000
> >...
> 
> 1. Please run this through ksymoops as described in
>    Documentation/oops-tracing.txt in the kernel source tree.
> 2. There are _many_ bug fixes in 2.4.19 compared to 2.4.17, could you
>    first try whether the problem still exists in 2.4.19?
> 
> cu
> Adrian
> 
> -- 
> 
> You only think this is a free country. Like the US the UK spends a lot of
> time explaining its a free country because its a police state.
> 								Alan Cox
> 
> 
> 


-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
