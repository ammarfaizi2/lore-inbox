Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWHGCHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWHGCHk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWHGCHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:07:40 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:14054 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750893AbWHGCHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:07:39 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
Date: Mon, 07 Aug 2006 12:07:34 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <jm7dd2d95ri4rq1n66cmgf5lpalm4fpnie@4ax.com>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 03:08:09 -0700, Andrew Morton <akpm@osdl.org> wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

Okay here, done some fdisk partition manipulation and didn't lose 
any filesystems or any other nasties. ;)  Dual boot 'doze, so 
stuffing around with NTFS (ro) as well as NFS (rw).

Some odd looking IRQ reassignments (Via chipset), I've put up 
-rc3 -> -rc3-mm2 dmesg diff, as well as dmesg and config on 
<http://bugsplatter.mine.nu/test/linux-2.6/sempro/> if anyone 
curious.

Grant.
