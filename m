Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbUKWEwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUKWEwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKWEu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:50:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:9934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261175AbUKWEZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 23:25:06 -0500
Date: Mon, 22 Nov 2004 20:24:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
Message-Id: <20041122202441.511c055d.akpm@osdl.org>
In-Reply-To: <41A27F77.9080401@mvista.com>
References: <419E6900.5070001@mvista.com>
	<20041119155854.02af2174.akpm@osdl.org>
	<41A27F77.9080401@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
> Andrew Morton wrote:
> 
>  >Anyway, I'll stick this as-is in -mm.  Feel free to send an incremental
>  >patch, or a replacement.
>  >
> 
>  Here is an incremental patch [hopefully] with your concerns addressed.  

OK, thanks.  I added this to the queue for post-2.6.10.  I'll assume that
silence means assent from the rest of the ppc team ;)

(Patches are at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/broken-out/ppc32-marvell-host-bridge-support-mv64x60.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/broken-out/ppc32-support-for-marvell-ev-64260-bp-eval-platform.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/broken-out/ppc32-support-for-artesyn-katana-cpci-boards.patch
