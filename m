Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUGZXhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUGZXhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUGZXhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:37:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:34961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266173AbUGZXhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:37:02 -0400
Date: Mon, 26 Jul 2004 16:35:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, hugh@veritas.com,
       torvalds@osdl.org
Subject: Re: [PATCH] prio_tree iterator cleanup.
Message-Id: <20040726163533.6f2fe0fa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407261626080.17181@red.engin.umich.edu>
References: <41027815.94F9D9AC@tv-sign.ru>
	<Pine.LNX.4.58.0407261626080.17181@red.engin.umich.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Venkatasubramanian <vrajesh@umich.edu> wrote:
>
> I have gone through all the 3 prio_tree patches you have sent
>  over the last few weeks. Your 2nd (kill vma_prio_tree_init) and
>  3rd (iterator cleanup) patches look straight-forward.
> 
>  I agree that vm_set.head linking is ugly. Your 1st patch
>  attempts to simplify it and removes few lines of code. However,
>  your 1st patch is intrusive and I am not convinced that it
>  improves the code very much.
> 
>  If you can post your 2nd and 3rd patches independent of your
>  first patch, that will be great. Please covert vma_prio_tree_next
>  in arch/* directories if you plan to post a new version of your
>  3rd patch.
> 
>  Overall I am inclined to leave the prio_tree code as it is.
>  However, your 2nd and 3rd patches are quiet straight-forward
>  and I am okay with them.

Thanks, Rajesh.

Oleg, I didn't apply any patches in this area.  Please reissue any
prio-tree patches from scratch.  Thanks.

