Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVCaPDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVCaPDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVCaPBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:01:23 -0500
Received: from mail.dif.dk ([193.138.115.101]:24802 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261490AbVCaPAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:00:45 -0500
Date: Thu, 31 Mar 2005 17:00:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: DervishD <lkml@dervishd.net>
Cc: Mariusz Mazur <mmazur@kernel.pl>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-libc-headers scsi headers vs libc scsi headers
In-Reply-To: <20050331141726.GA654@DervishD>
Message-ID: <Pine.LNX.4.62.0503311659040.7825@jjulnx.backbone.dif.dk>
References: <20050330162114.GA1028@DervishD> <200503302240.08200.mmazur@kernel.pl>
 <20050331074526.GA8614@DervishD> <200503311426.48435.mmazur@kernel.pl>
 <20050331141726.GA654@DervishD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, DervishD wrote:

> Date: Thu, 31 Mar 2005 16:17:26 +0200
> From: DervishD <lkml@dervishd.net>
> To: Mariusz Mazur <mmazur@kernel.pl>
> Cc: Linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: linux-libc-headers scsi headers vs libc scsi headers
> 
>     Hi Mariusz :)
> 
>  * Mariusz Mazur <mmazur@kernel.pl> dixit:
> > >     I don't know which set of headers will work, and in fact I don't
> > > know if I must follow 'Linux From Scratch' advice and use raw kernel
> > > headers for building glibc and LLH headers for any other thing. I
> > > think I probably will use the LLH headers (including scsi) for
> > > everything since glibc passes the 'make check' doing that... If I
> > > screw my system badly, I have lotsa backups at hand.
> > Like I've said, you're unable to break your system this way.
> 
>     I think so... 
> 
> > And I don't see any point in LFS suggesting using raw kernel
> > headers to compile glibc
> 
>     I don't know their reasons because I haven't read any rationale
> (if any exists at all). Anyway, I've used LLH (including the scsi


http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html seems to have a 
bearing on what you are discussing - just FYI.


-- 
Jesper Juhl

