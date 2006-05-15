Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWEOR56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWEOR56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWEOR55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:57:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965026AbWEOR55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:57:57 -0400
Date: Mon, 15 May 2006 11:00:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060515110023.0ee5e7ad.akpm@osdl.org>
In-Reply-To: <6bffcb0e0605151048r314132cdvedf7c33b3c945c72@mail.gmail.com>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151048r314132cdvedf7c33b3c945c72@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> >
> > - This tree contains a large number of new bugs^H^H^H^Hpatches.
> >
> [snip]
> > +kbuild-export-symbol-usage-report-generator.patch
> 
> When I try make exportcheck with O=/dir I get this error
> [michal@ltg01-fedora linux-mm]$ make O=../linux-mm-obj/ exportcheck
> EXPORTFILE=../linux-mm-obj/export.dat
>   Using /usr/src/linux-mm as source for kernel
> [..]
> Can't open perl script
> "/usr/src/linux-mm-obj/scripts/export_report.pl": No such file or
> directory
> make[2]: *** [__modpost] Error 2
> make[1]: *** [modules] Error 2
> make: *** [exportcheck] Error 2
> 
> Regards,
> Michal
> 

cc added.
