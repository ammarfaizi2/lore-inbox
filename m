Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129279AbQKGW3n>; Tue, 7 Nov 2000 17:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbQKGW3d>; Tue, 7 Nov 2000 17:29:33 -0500
Received: from rsn-rby-gw.hk-r.se ([194.47.128.222]:32425 "EHLO
	tux.rsn.hk-r.se") by vger.kernel.org with ESMTP id <S129279AbQKGW3W>;
	Tue, 7 Nov 2000 17:29:22 -0500
Date: Tue, 7 Nov 2000 23:28:31 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Tigran Aivazian <tigran@veritas.com>
cc: Anil kumar <anils_r@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011072137120.3574-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011072328050.22346-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Tigran Aivazian wrote:

> On Tue, 7 Nov 2000, Anil kumar wrote:
> >   The system hangs after messages:
> >   loading linux......
> >   uncompressing linux, booting linux kernel OK.
> > 
> >   The System hangs here.
> > 
> >   Please let me know where I am wrong
> 
> Hi Anil,
> 
> The only serious mistake you did was using test9 kernel when test11-pre1
> (or at least test10) was available. So, redo everything you have done with
> test11-pre1 and if you still cannot boot then send a message to this list
> with details like your CPUs, motherboard etc. etc.

Have you chosen the right cpu type in the configuration?

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
