Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSEALqU>; Wed, 1 May 2002 07:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSEALqT>; Wed, 1 May 2002 07:46:19 -0400
Received: from [195.163.186.27] ([195.163.186.27]:10138 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S310917AbSEALqS>;
	Wed, 1 May 2002 07:46:18 -0400
Date: Wed, 1 May 2002 14:46:16 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Abdij Bhat <Abdij.Bhat@kshema.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is the inetd.conf?
Message-ID: <20020501144616.H1284@mea-ext.zmailer.org>
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D1013704C@BHISHMA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 05:11:53PM +0530, Abdij Bhat wrote:
> Hi,
>  I no longer find the inetd.conf in either /etc or /etc/inet/. In fact i do
>  not find in on my whole linux box.
>  I am using Red Hat Distribution of Linux Kernel 2.4.7-10. I beleive it is
>   using xinetd instead of inetd.

  That question is not of "linux-kernel", rather it is of which
  distribution you do use.

  Answers for your question can be found by:  man xinetd
  and man-pages it refers to.

  It has built-in tcp-wrapper usage code, see the documentation of
  how to use it.

> Thanks and Regards,
> Abdij
