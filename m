Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264081AbRFSJLh>; Tue, 19 Jun 2001 05:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264082AbRFSJL0>; Tue, 19 Jun 2001 05:11:26 -0400
Received: from mail.myrealbox.com ([192.108.102.201]:3256 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S264081AbRFSJLR>;
	Tue, 19 Jun 2001 05:11:17 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 19 Jun 2001 11:13:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.5 data corruption
Message-ID: <3B2F33BE.22085.185CE2A5@localhost>
In-Reply-To: <20010619050037.B2512@stefan.sime.com>
In-Reply-To: <E15Abiw-00056O-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 07:20:06PM +0100
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 2001, at 5:00, Stefan Traby wrote:

> On Thu, Jun 14, 2001 at 07:20:06PM +0100, Alan Cox wrote:
> > > Folks, I believe I have a reproducible test case which corrupts
> > > data in 2.4.5.
> > 
> > 2.4.5 has an out of date 3ware driver that is short
> 
> > +   1.02.00.007 - Fix possible null pointer dereferences in
> > +   tw_ioctl().
> > +                 Remove check for invalid done function pointer
> > +                 from tw_scsi_queue().
> 
> hehe, this one keeps the 3dmd from running here at all.

  Saw that one here too. 

[...]

> (like DAC); I guess that many people would love to get rid
> of the - sorry - fucking closed sourced and totally broken 3dmd
> which makes an extremly nice product totally useless (you can't
> trust it; not only because it's closed source, it simply doesn't
> work (except that it wastes memory, that works fine. tested.))
> 
> -- 

   3dmd does have a lot of problems, but i thought it was just me. I 
only made it work once in a machine, and not very well. Last week 
i installed the latest version in another of my machines and after 
half an hour wrestling with it - trying to make it change passwords 
and ask for one, among other things - i gave up.


> 
>   ciao - 
>     Stefan
> 

Pedro
