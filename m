Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279912AbRKVQC3>; Thu, 22 Nov 2001 11:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRKVQCU>; Thu, 22 Nov 2001 11:02:20 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:4979 "EHLO
	c0mailgw12.prontomail.com") by vger.kernel.org with ESMTP
	id <S277258AbRKVQCD>; Thu, 22 Nov 2001 11:02:03 -0500
Message-ID: <3BFD214F.36A55D94@starband.net>
Date: Thu, 22 Nov 2001 11:01:19 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <01112211150302.00690@argo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, I have enough ram where I am not going to run out for the things I
do.
I never need swap.

When the system swaps, it slows down the system responsiveness big time.


Oliver Neukum wrote:

> Am Donnerstag 22 November 2001 02:53 schrieb war:
> > I do not understand something.
> >
> > How can having swap speed ANYTHING up?
> >
> > RAM = 1000MB/s.
> > DISK = 10MB/s
> >
> > Ram is generally 1000x faster than a hard disk.
> >
> > No swap = fastest possible solution.
>
> At some point you will run out of ram. Then you have to start paging. The
> only question there is whether you page only mmaped files including program
> code or whether you also write out program data.
>
>         HTH
>                 Oliver

