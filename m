Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129537AbRCBVxs>; Fri, 2 Mar 2001 16:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129540AbRCBVxj>; Fri, 2 Mar 2001 16:53:39 -0500
Received: from [208.204.44.103] ([208.204.44.103]:54277 "EHLO
	warpcore.provalue.net") by vger.kernel.org with ESMTP
	id <S129537AbRCBVxX>; Fri, 2 Mar 2001 16:53:23 -0500
Date: Fri, 2 Mar 2001 15:03:30 -0600 (CST)
From: Collectively Unconscious <swarm@warpcore.provalue.net>
To: linux-kernel@vger.kernel.org
Subject: I/O problem with sustained writes
In-Reply-To: <3AA00D5A.44FA21D0@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10103021455500.29369-100000@warpcore.provalue.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are having a problem with writes.
They start at 14 M/s for the first hour and then drop to 2.5 M/s and stay
that way. Reads do not seem effected and we've noticed this on the 2.2.16,
2.2.17, 2.2.18 and now the 2.2.19pre11 kernels.

These are SMP P-IIIs from 450 to 800 MHz. Redhat 6.2

Jay

