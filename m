Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130282AbRA3VK6>; Tue, 30 Jan 2001 16:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130694AbRA3VKt>; Tue, 30 Jan 2001 16:10:49 -0500
Received: from [64.16.10.150] ([64.16.10.150]:12048 "EHLO cougar.intrinsyc.com")
	by vger.kernel.org with ESMTP id <S130282AbRA3VKk>;
	Tue, 30 Jan 2001 16:10:40 -0500
Message-ID: <3A77670F.AF26FE59@intrinsyc.com>
Date: Tue, 30 Jan 2001 20:14:56 -0500
From: Daniel Chemko <dchemko@intrinsyc.com>
Reply-To: dchemko@intrinsyc.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David L. Nicol" <david@kasey.umkc.edu>
CC: dwen@javapond.com, linux-kernel@vger.kernel.org
Subject: Re: How can I understand Linux Network implementation?
In-Reply-To: <20010127022533.3CDBF36F9@sitemail.everyone.net> <3A771EDC.58D2FE8D@kasey.umkc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Save yourself the headache.

Despite the fact that it is based on the 2.2 network core, the Coriolis book
Linux IP Stacks was a good book of source code to scip to parts of the code
which was related to my interests. It may be a little different now, with the
iptables rework, but besides that, it is a good introduction to the
implementation of the low level protcols.


"David L. Nicol" wrote:

> Donghui Wen wrote:
> >
> > I am hacking the implementation of linux2.4's
> > networking (IPV4) . Can anyone give me some idea
> > what material I should read to understand the
> > data structures and algorithms. I have stevens's
> > books which talked about BSD's implementation.
> >
> > Thanks!
> >
> > Donghui
>
> Print it all out
>
> read the source code
>
> I like the a2ps tool for formatting source code for reading;
> I print out a sheaf of source code and retreat to a local coffee emporium
> with a highlighter and a legal pad.
>
> --
>                       David Nicol 816.235.1187 dnicol@cstp.umkc.edu
>                                      2.4.0 seems faster than 2.2.16
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
