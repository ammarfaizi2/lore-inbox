Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUHaR1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUHaR1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUHaRZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:25:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11421 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268760AbUHaRPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:15:32 -0400
Message-ID: <4134B221.9070203@pobox.com>
Date: Tue, 31 Aug 2004 13:15:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [DOC] Linux kernel patch submission format
References: <413431F5.9000704@pobox.com> <1093970261.6200.45.camel@localhost.localdomain>
In-Reply-To: <1093970261.6200.45.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> --- patch-format.html.orig
> +++ patch-format.html
> @@ -83,6 +83,15 @@
>  for the 5th time, resist the urge to attach 20 patches to a single
>  email.
>  
> +</li><li><h2>One thread per set of patches</h2>
> +
> +The corollary to the above rule: when sending more than one patch in
> +separate emails, make sure they stay together. Send the second and
> +subsequent mails as <em>replies</em> to the first mail, rather than
> +having each one start its own thread. (You should also ensure that
> +your mail client obeys RFC2822 by including correct
> +<TT>References:</TT> headers in replies.)
> +


hmmmm.  While I do agree with the content, I'm trying to avoid 
lengthening this page.  If we describe every little detail, then it 
becomes long -- just like SubmittingPatches -- and everybody will skip 
reading it.

	Jeff


