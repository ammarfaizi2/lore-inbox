Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUCPIz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUCPIz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:55:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:27015 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263567AbUCPIz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:55:27 -0500
Date: Tue, 16 Mar 2004 00:52:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       greg@kroah.com, bos@serpentine.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
Message-Id: <20040316005229.53e08c0c.akpm@osdl.org>
In-Reply-To: <4056B0DB.9020008@pobox.com>
References: <4056B0DB.9020008@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Too big to post,
> 
>  http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.5-rc1-klibc1.patch.bz2
>  	or
>  bk://kernel.bkbits.net/jgarzik/klibc-2.5
> 
>  IIRC, this is:  my update of Bryan O'Sullivan's update of Greg KH's 
>  update of my merge of hpa's and viro's hacking :)
> 
>  WRT overall klibc merge:  when it can do md RAID autorun, it's 
>  mergeable.  And didn't somebody write a tiny mdctl program...

It's so long since klibc was discussed (ie: more than five minutes ago)
that I forget the reasons why it should be delivered via the kernel tree.

Remind me please?
