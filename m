Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282261AbRKWWIq>; Fri, 23 Nov 2001 17:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282260AbRKWWIg>; Fri, 23 Nov 2001 17:08:36 -0500
Received: from [209.249.147.248] ([209.249.147.248]:38152 "EHLO
	proxy1.addr.com") by vger.kernel.org with ESMTP id <S282258AbRKWWIV>;
	Fri, 23 Nov 2001 17:08:21 -0500
Date: Fri, 23 Nov 2001 17:05:20 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: James A Sutherland <jas88@cam.ac.uk>
Cc: war@starband.net, oliver@neukum.org, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
Message-Id: <20011123170520.2276b8be.dang@fprintf.net>
In-Reply-To: <E166wSm-00063a-00@mauve.csi.cam.ac.uk>
In-Reply-To: <3BFC5A9B.915B77DF@starband.net>
	<01112211150302.00690@argo>
	<3BFD214F.36A55D94@starband.net>
	<E166wSm-00063a-00@mauve.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001 16:12:32 +0000
James A Sutherland <jas88@cam.ac.uk> wrote:

> "when it swaps" is meaningless: Linux ALWAYS swaps when there is swapspace. 
> Do you mean when it *thrashes*? Or does your system have problems during I/O

> such as not using DMA for disk access?

[17:03 athena] dang> free
             total       used       free     shared    buffers     cached
Mem:        255304     184416      70888        716      12636      77524
-/+ buffers/cache:      94256     161048
Swap:       128484          0     128484
[17:03 athena] dang> uname -a
Linux athena.fprintf.net 2.4.13-ac7-preempt-sse #1 Mon Nov 5 14:06:53 EST 2001
i686 unknown
[17:04 athena] dang> 

Linux does not always swap.

Daniel

--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

