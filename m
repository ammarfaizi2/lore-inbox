Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWEARB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWEARB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWEARB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:01:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932156AbWEARB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:01:26 -0400
Date: Mon, 1 May 2006 09:59:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3-mm1
Message-Id: <20060501095913.13a74b2b.akpm@osdl.org>
In-Reply-To: <625fc13d0605010554l4cadac0fxe7fbc6cd5d57c679@mail.gmail.com>
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	<625fc13d0605010554l4cadac0fxe7fbc6cd5d57c679@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Josh Boyer" <jwboyer@gmail.com> wrote:
>
>  On 5/1/06, Andrew Morton <akpm@osdl.org> wrote:
>  >
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/
>  >
>  >
>  > - Added git-rbtree.patch to the -mm lineup (David Woodhouse).  It shrinks
>  >   the rb-tree nodes.
>  >
>  > - Added git-sas.patch to the -mm lineup (James Bottomley).  aic94xx serial
>  >   attached storage driver.
>  >
>  > - Added git-supertrak.patch to the -mm lineup (Jeff Garzik).  A driver for
>  >   Promise SuperTrak controllers, from Promise.
> 
>  Hi Andrew,
> 
>  Any specific reasons the header cleanup trees weren't added?

I'll get onto that later in the month.  I also need to bring in the klibc
tree.  The two might apparently interact - we'll see..
