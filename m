Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279040AbRKFJfo>; Tue, 6 Nov 2001 04:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278967AbRKFJfe>; Tue, 6 Nov 2001 04:35:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49671 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278722AbRKFJfZ>; Tue, 6 Nov 2001 04:35:25 -0500
Subject: Re: ext3-0.9.15 against linux-2.4.14
To: akpm@zip.com.au (Andrew Morton)
Date: Tue, 6 Nov 2001 09:42:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml),
        ext3-users@redhat.com (ext3-users@redhat.com)
In-Reply-To: <3BE7AB6C.97749631@zip.com.au> from "Andrew Morton" at Nov 06, 2001 01:20:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1612k8-0008Id-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   There are no plans to remove this semaphore from -ac kernels,
>   unless Alan wants it that way.

That should just come out by magic as the VM and other stuff converge
