Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVC2IPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVC2IPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVC2IOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:14:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:19100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262456AbVC2HY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:24:28 -0500
Date: Mon, 28 Mar 2005 23:23:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: claw network device driver
Message-Id: <20050328232359.4f1e04b9.akpm@osdl.org>
In-Reply-To: <20050329071210.GA16409@havoc.gtf.org>
References: <200503290533.j2T5XEYT028850@hera.kernel.org>
	<4248FBFD.5000809@pobox.com>
	<20050328230830.5e90396f.akpm@osdl.org>
	<20050329071210.GA16409@havoc.gtf.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  > Was cc'ed to linux-net last Thursday, but it looks like the messages was
>  > too large and the vger server munched it.
> 
>  This also brings up a larger question... why was a completely unreviewed
>  net driver merged?

Because nobody noticed that it didn't make it to the mailing list,
obviously.

