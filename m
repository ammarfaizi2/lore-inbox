Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265623AbRGCIec>; Tue, 3 Jul 2001 04:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265621AbRGCIeW>; Tue, 3 Jul 2001 04:34:22 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:18963 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S265605AbRGCIeM>; Tue, 3 Jul 2001 04:34:12 -0400
Date: Tue, 3 Jul 2001 14:22:32 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Reg kdb utility
In-Reply-To: <Pine.LNX.4.10.10107012004510.30427-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10107031311370.6784-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to use kdb on my 2.2.14-12 kernel. I was able to compile the file 
/usr/src/linux/arch/i386/kdb/modules/kdbm_vm.c and could get the object
file. When I tried to insert it as a module it givesd the following error
message:

./kdbm_vm.o: kernel-module version mismatch
        ./kdbm_vm.o was compiled for kernel version .2.14-12
        while this kernel is version 2.2.14-12.



Please tell me why this message comes.

Thanks in advance,

Regards,
satish.j








