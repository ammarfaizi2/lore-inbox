Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUH1Wp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUH1Wp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUH1Wp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:45:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268073AbUH1WnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:43:07 -0400
Message-ID: <41310A6B.8030806@pobox.com>
Date: Sat, 28 Aug 2004 18:42:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net, James Bottomley <James.Bottomley@steeleye.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi_mid_low_api.txt update
References: <200408282022.i7SKM8jN010051@hera.kernel.org>
In-Reply-To: <200408282022.i7SKM8jN010051@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> @@ -1420,15 +1503,16 @@
>  Credits
>  =======
>  The following people have contributed to this document:
> -        Mike Anderson <andmike@us.ibm.com>
> -        James Bottomley <James.Bottomley@steeleye.com> 
> -        Patrick Mansfield <patmans@us.ibm.com> 
> -        Christoph Hellwig <hch@infradead.org>
> -        Doug Ledford <dledford@redhat.com>
> -        Andries Brouwer <Andries.Brouwer@cwi.nl>
> -        Randy Dunlap <rddunlap@osdl.org>
> +        Mike Anderson <andmike at us dot ibm dot com>
> +        James Bottomley <James dot Bottomley at steeleye dot com> 
> +        Patrick Mansfield <patmans at us dot ibm dot com> 
> +        Christoph Hellwig <hch at infradead dot org>
> +        Doug Ledford <dledford at redhat dot com>
> +        Andries Brouwer <Andries dot Brouwer at cwi dot nl>
> +        Randy Dunlap <rddunlap at osdl dot org>
> +        Alan Stern <stern at rowland dot harvard dot edu>
>  
>  
>  Douglas Gilbert
> -dgilbert@interlog.com
> -29th August 2003
> +dgilbert at interlog dot com
> +25th August 2004


I hate to break it to ya, but this doesn't do much of anything 
anymore...  it's an easy (and quite common) regex to find addresses 
modified in this way.

All it really does it make it impossible to cut-n-paste email addresses 
without having to hand-modify them.

	Jeff


