Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284807AbRLDAU6>; Mon, 3 Dec 2001 19:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284811AbRLDARL>; Mon, 3 Dec 2001 19:17:11 -0500
Received: from [139.85.108.65] ([139.85.108.65]:4491 "EHLO rpppc1.hns.com")
	by vger.kernel.org with ESMTP id <S284587AbRLCOG2>;
	Mon, 3 Dec 2001 09:06:28 -0500
To: linux-kernel@vger.kernel.org
Subject: nfs: task can't get a request slot
From: nbecker@fred.net
Date: 03 Dec 2001 09:06:23 -0500
Message-ID: <x88u1v8jt40.fsf@rpppc1.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experience hung processes.

This is:
2.4.9-13 #1 Tue Oct 30 19:32:27 EST 2001 i686 unknown

What does this mean?

Dec  3 08:53:54 rpppc1 kernel: nfs: server adglinux1 not responding, still trying
Dec  3 08:53:54 rpppc1 kernel: nfs: server adglinux1 not responding, still trying
Dec  3 08:55:09 rpppc1 rpc.mountd: authenticated mount request from 139.85.108.152:890 for /disk1/nbecker (/disk1) 
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3408 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3409 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3410 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3411 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3412 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3413 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3414 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3415 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3416 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3417 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3418 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3419 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3420 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3421 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3422 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3423 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3424 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3425 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3426 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3427 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3428 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3429 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3430 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3431 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3432 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3433 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3434 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3435 can't get a request slot
Dec  3 08:55:43 rpppc1 kernel: nfs: task 3436 can't get a request slot
Dec  3 08:55:47 rpppc1 kernel: nfs: task 3437 can't get a request slot
