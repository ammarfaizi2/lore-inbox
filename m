Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSKAKyZ>; Fri, 1 Nov 2002 05:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265690AbSKAKyZ>; Fri, 1 Nov 2002 05:54:25 -0500
Received: from mail.scram.de ([195.226.127.117]:65222 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S265689AbSKAKyY>;
	Fri, 1 Nov 2002 05:54:24 -0500
Date: Fri, 1 Nov 2002 11:55:00 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] Oops when accessing /proc/net/llc/core
Message-ID: <Pine.LNX.4.44.0211011145040.14458-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IIRC, this has been reported before. I get this message after a cat
/proc/net/llc/core on 2.5.44. No further oops or trace.

Unable to handle kernel paging request at virtual address 00000200001858c0
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--jochen

