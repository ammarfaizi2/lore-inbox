Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbTH3FZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 01:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTH3FZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 01:25:22 -0400
Received: from coffee.creativecontingencies.com ([210.8.121.66]:7081 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S261469AbTH3FZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 01:25:19 -0400
Message-Id: <5.1.0.14.2.20030830152430.01be2350@caffeine.cc.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 30 Aug 2003 15:25:11 +1000
To: linux-kernel@vger.kernel.org
From: Peter Lieverdink <cafuego@cc.com.au>
Subject: Re: 2.6.0-test4-mm2: fdisk causes Oops
In-Reply-To: <1062133972.499.5.camel@kahlua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: I can't reproduce this under 2.6.0-test4-mm3-1

- Peter.
--
At 15:12 29/08/2003 +1000, you wrote:
>Hi,
>
>When running fdisk -l under 2.6.0-test4-mm2, the kernel oopses. dmesg,
>the oops (fdisk.txt) and output from lspci are attached.
>
>I've tried after disabling the Promise controller in the BIOS, but the
>oops still occurs. Same when I specify a device instead of -l.
>
>fdisk is from debian/unstable, version 2.11z
>
>- Peter.

