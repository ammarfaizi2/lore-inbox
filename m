Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263695AbREYK6J>; Fri, 25 May 2001 06:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263697AbREYK57>; Fri, 25 May 2001 06:57:59 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:56584 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S263695AbREYK5r>; Fri, 25 May 2001 06:57:47 -0400
Date: Fri, 25 May 2001 16:47:34 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg:usage of insmod
In-Reply-To: <Pine.LNX.4.10.10105251239050.11760-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10105251644290.20579-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for disturbing you with my doubt.

I tried to insert a module(my own object file called dssp.o) into the
running kernel and i got the following:


[root@juhie fs]# insmod  -o ./dssp.o -f dssp
Using /lib/modules/2.2.14-12/fs/dssp.o
/lib/modules/2.2.14-12/fs/dssp.o: couldn't find the kernel version the
module was compiled for


I could not make out why this error message came. Please help me out with
this.


Thanks in advance

regards,
sathish

