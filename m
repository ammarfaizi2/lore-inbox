Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266684AbRGTH3c>; Fri, 20 Jul 2001 03:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbRGTH3V>; Fri, 20 Jul 2001 03:29:21 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:26383 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S266684AbRGTH3O>; Fri, 20 Jul 2001 03:29:14 -0400
Date: Fri, 20 Jul 2001 09:27:44 +0200 (CEST)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "David S. Miller" <davem@redhat.com>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.7-pre9.
In-Reply-To: <15191.53042.470246.343943@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0107200927280.587-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 19 Jul 2001, David S. Miller wrote:

>
> Niels Kristian Bech Jensen writes:
>  > >>EIP; c01467e3 <proc_pid_make_inode+83/b0>   <=====
>
> This should fix it:
>
It does, thanks.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

