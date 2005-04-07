Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVDGR6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVDGR6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVDGR6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:58:52 -0400
Received: from bay101-f11.bay101.hotmail.com ([64.4.56.21]:44039 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262540AbVDGR61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:58:27 -0400
Message-ID: <BAY101-F113E9AB68648FB65506DDDDC3E0@phx.gbl>
X-Originating-IP: [64.4.56.200]
X-Originating-Email: [danieljlaird@hotmail.com]
From: "Daniel Laird" <danieljlaird@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: mipsel-linux-ld vmlinux.lds:470: Parse Error
Date: Thu, 07 Apr 2005 17:58:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Apr 2005 17:58:21.0202 (UTC) FILETIME=[62B66F20:01C53B9B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to build a linux kernel and toolchain for a le mips processor

I have the following versions
binutils-2.15.96
gcc-3.4.3
glibc-2.3.4
linux kernel 2.6.11.6

When it build all build fine and it gets to the kernel and build all the 
code and then i get this error

LD .tmp_vmlinux1
mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:470: parse error
make: ***[.tmp_vmlinux1] Error 1

I can see that someone else has had this problem and the advice was hack it 
and try again.

http://www.linux-mips.org/archives/linux-mips/2005-01/msg00059.html

But this is not good in a complete build environment so does anyone know 
what causes this bug and what i can do to solve it

Please help and thanks in advance
DJL


