Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283123AbRK2Jct>; Thu, 29 Nov 2001 04:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283122AbRK2Jc3>; Thu, 29 Nov 2001 04:32:29 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:41161 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283120AbRK2JcT>; Thu, 29 Nov 2001 04:32:19 -0500
Date: Thu, 29 Nov 2001 10:32:05 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: "Nathan G. Grennan" <ngrennan@okcforum.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16 revisited
In-Reply-To: <1007024821.1528.3.camel@cygnusx-1.okcforum.org>
Message-ID: <Pine.LNX.4.42.0111291030390.1191-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 2001, Nathan G. Grennan wrote:

> ok, I doubled checked things. It seems mounting an ext3 filesystem as
> ext2 is somewhat a myth. If the kernel supports ext3 it still mounts it
> as ext3 even if /etc/fstab says ext2. 

really on other partitions than root-fs ?

-- 
Oktay Akbal

