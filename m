Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263797AbRFJAQd>; Sat, 9 Jun 2001 20:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbRFJAQX>; Sat, 9 Jun 2001 20:16:23 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:38414 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S263797AbRFJAQL>; Sat, 9 Jun 2001 20:16:11 -0400
Date: Sat, 9 Jun 2001 20:17:56 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: Shawn Starr <spstarr@sh0n.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.6-pre2 patch buglet
In-Reply-To: <Pine.LNX.4.30.0106092003060.28896-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.33.0106092017390.12366-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it me or does this patch forget to change the kernel version? ;-)
> make menuconfig reports pre1 still.. oh well no biggie..

yes, this is a mistake. the Makefile had not been updated.

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


