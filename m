Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUABADl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUABADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:03:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:59068 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261779AbUABADk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:03:40 -0500
Date: Thu, 1 Jan 2004 16:04:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-Id: <20040101160420.6a326d0a.akpm@osdl.org>
In-Reply-To: <20040101235147.GC1718@actcom.co.il>
References: <20031229183846.GI13481@actcom.co.il>
	<Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
	<20040101235147.GC1718@actcom.co.il>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> wrote:
>
> Ok, I've done this now. The indentation patch is 137k, and is
>  available at
>  http://www.mulix.org/patches/trident-cleanup-indentation-D1-2.6.0.patch
>  (gzipped:
>  http://www.mulix.org/patches/trident-cleanup-indentation-D1-2.6.0.patch.gz).

hmm, how come a whitespace cleanup patch adds nearly 200 lines which have
trailing whitespace?

>  All of the non-indentation changes are in the
>  trident-cleanup-fixes-D1-2.6.0 patch, attached here inline. It needs
>  the indentation patch to be applied before it to apply
>  cleanly. Compiles, boots and plays music fine. Patch is against
>  2.6.0. Andrew, please add these two patches to -mm1 instead of the
>  "humongopatch" currently there. Thanks! 

Could we please have a description of the substantive changes in
this patch?

Thanks.
