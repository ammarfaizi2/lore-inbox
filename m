Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276474AbRJPQ1x>; Tue, 16 Oct 2001 12:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276470AbRJPQ1o>; Tue, 16 Oct 2001 12:27:44 -0400
Received: from adsl-66-120-162-175.dsl.sntc01.pacbell.net ([66.120.162.175]:18430
	"EHLO devel.office") by vger.kernel.org with ESMTP
	id <S276369AbRJPQ1Z>; Tue, 16 Oct 2001 12:27:25 -0400
Date: Tue, 16 Oct 2001 09:27:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: <christoph@devel.office>
To: <linux-kernel@vger.kernel.org>
Subject: GPLONLY kernel symbols???
Message-ID: <Pine.LNX.4.33.0110160927030.24895-100000@devel.office>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to load the loop driver in 2.4.11

devel:/home/christoph/devel/bf/boot-floppies# insmod loop
Using /lib/modules/2.4.11/kernel/drivers/block/loop.o
/lib/modules/2.4.11/kernel/drivers/block/loop.o: unresolved symbol
invalidate_bdev
/lib/modules/2.4.11/kernel/drivers/block/loop.o: Note: modules without a
GPL compatible license cannot use GPLONLY_ symbols

What is THAT?


