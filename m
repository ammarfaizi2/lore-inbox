Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWD2Pqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWD2Pqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 11:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWD2Pqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 11:46:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750748AbWD2Pqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 11:46:33 -0400
Date: Sat, 29 Apr 2006 08:44:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 0/6] UML - Small patches for 2.6.17
Message-Id: <20060429084430.27ea0d91.akpm@osdl.org>
In-Reply-To: <200604291641.19864.blaisorblade@yahoo.it>
References: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org>
	<20060428165534.6067f5aa.akpm@osdl.org>
	<200604291641.19864.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> > Unless one considers 
>  > UML coding style to be a bug, which is an attractive idea ;)
> 
>  Well, we're slowly working on that... very slowly... I've thought multiple 
>  times to at least run Lindent on arch/um but I've not spoken up because of 
>  all the conflicts we (me and Jeff) would get with patches in our queues.

Lindent doesn't do a terribly good job, and one ends up having to perform a
lot of manual fixups.  Perhaps as many as are presently needed.

