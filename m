Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUHSNZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUHSNZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUHSNZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:25:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35971 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266096AbUHSNZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:25:36 -0400
Date: Thu, 19 Aug 2004 09:25:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: CD/DVD record
Message-ID: <Pine.LNX.4.53.0408190917140.19253@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all...
Recording this stuff is basically sending some commands to
a device and then keeping a FIFO full until done.

If `cdrecord` doesn't do it, one can hack together something
that works in a day or so,... really good stuff in a week.
Maybe it's time to ......  anyway ..... the device characteristics
should be kept in an ASCII text file so the software doesn't have
to be re-written everytime a new CD recorder becomes available.

Maybe the `cdrecord` author needs some competition. This sounds
like a good beginner's project....

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


