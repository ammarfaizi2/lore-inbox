Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276452AbRJCQUv>; Wed, 3 Oct 2001 12:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276457AbRJCQUm>; Wed, 3 Oct 2001 12:20:42 -0400
Received: from hera.cwi.nl ([192.16.191.8]:14512 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S276452AbRJCQUf>;
	Wed, 3 Oct 2001 12:20:35 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 3 Oct 2001 16:21:03 GMT
Message-Id: <200110031621.QAA03519@vlet.cwi.nl>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: partition table read incorrectly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Maybe there is still "0xaa55" on the disk at 0x1fe and the kernel
>> thinks it is a DOS partition?

> Note that that is true for *ANY* partition scheme which is bootable,
> since this is a requirement of the boot firmware interface, rather of
> any particular partitioning scheme...

You mean on i386 hardware? With the most common BIOS versions?

