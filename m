Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131453AbRAJV5n>; Wed, 10 Jan 2001 16:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRAJV5W>; Wed, 10 Jan 2001 16:57:22 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:60540 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S131692AbRAJV5P>; Wed, 10 Jan 2001 16:57:15 -0500
Message-Id: <200101102157.f0ALvCr01485@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: kernel@ddx.a2000.nu
cc: linux-kernel@vger.kernel.org
Subject: Re: unexplained high load 
In-Reply-To: Your message of "Wed, 10 Jan 2001 22:49:27 +0100."
             <Pine.LNX.4.30.0101102247510.4377-100000@ddx.a2000.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 16:57:12 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .nfs0000000000ca402500000006
> 
> so i think there is some lock from the nfs server or client
> 
> will try to restart nfs client
> and see if this fixes it.
> 

Most likely you will have to restart the nfs server on the other side as well, 
but it's worth a try.

Tripwire watches the checksum of the binaries you deem important, and 
complains if they change. There are a few things like it.

See http://freshmeat.net/search/?q=tripwire



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
