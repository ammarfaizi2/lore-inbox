Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317144AbSFWVxq>; Sun, 23 Jun 2002 17:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSFWVxp>; Sun, 23 Jun 2002 17:53:45 -0400
Received: from host.greatconnect.com ([209.239.40.135]:43538 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317144AbSFWVxo>; Sun, 23 Jun 2002 17:53:44 -0400
Subject: Re: kernel taint
From: Samuel Flory <sflory@rackable.com>
To: Qin Tao <qtao@cisunix.unh.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.44.0206231524160.455830-100000@hypatia.unh.edu>
References: <Pine.OSF.4.44.0206231524160.455830-100000@hypatia.unh.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Jun 2002 14:53:11 -0700
Message-Id: <1024869196.2168.452.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  If this is a module in the RH kernel this may just be due to
mislabeling of the license string.  What's the module?

On Sun, 2002-06-23 at 12:37, Qin Tao wrote:
> Hi,
> 
> I am using redhat7.3 (kernel 2.4.18-3). When I tried to insert a
> kernel module, I got the following warning message:
> 
> "Warning: loading mymodule.o will taint the kernel: forced load"
> 
> I didn't see this problem when I inserted the module to some earlier
> version kernels, such as 2.4.15. Does anybody know what does the warning
> message mean and how can I modify my module code to avoid that?
> 
> Thanks in advance.
> 
> Qin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


