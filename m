Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135484AbRDZXgP>; Thu, 26 Apr 2001 19:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135923AbRDZXgG>; Thu, 26 Apr 2001 19:36:06 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:59152 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S135490AbRDZXfu>;
	Thu, 26 Apr 2001 19:35:50 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2001 21:10:01 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Tore Johansson <nrjtore@toa006.nrj.ericsson.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tiny little problem
Message-Id: <20010425211001.2d1f4ab4.bruce@ask.ne.jp>
In-Reply-To: <200104260504.OAA16871@toa006>
In-Reply-To: <200104260504.OAA16871@toa006>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

This is a well-known problem; check the list archives for more info.


On Thu, 26 Apr 2001 14:04:23 +0900 (JST)
Tore Johansson <nrjtore@toa006.nrj.ericsson.se> wrote:

> Hi,
> 
> I have a problem with accessing a magneto opto drive in Linux.
> Since I upgraded the kernel from 2.3 to 2.4 I can mount the MO
> drive but if I try to access a file on the drive the kernel oopses...
> 
> After the kernel oops the MO can't be unmounted.
> 
> The MO is has a SCSI-2 interface and the SCSI interface is a Symbios
> NCR8xx type.
> 
> Any ideas??
> 
> Cheers,
> /Tore
