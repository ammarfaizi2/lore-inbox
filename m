Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUHDX0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUHDX0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHDX0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:26:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:30874 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267505AbUHDX0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:26:04 -0400
Date: Wed, 4 Aug 2004 16:29:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss update [1 of 6]
Message-Id: <20040804162928.5c3d2262.akpm@osdl.org>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107436092@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF107436092@cceexc23.americas.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miller, Mike (OS Dev)" <mike.miller@hp.com> wrote:
>
> Patch 1 of 6
> Name: p001_ioctl32_fix_for_268rc2.patch

It would make life easier for me if you could give each patch a nice
Subject: which describes what it does.  "cciss update [N of 6]" isn't very
meaningful.  And the name of the file into which you chose to place the
patch isn't a suitable description either.  Thanks.

All of these patches are generating rejects for me - eager beavers have
been patching your driver when you weren't looking.  Could you please redo
and reissue the patch series against -rc3?

Thanks.
