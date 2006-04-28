Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWD1Lal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWD1Lal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWD1Lal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:30:41 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:13328 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S965092AbWD1Lak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:30:40 -0400
Message-ID: <4451FCCC.4010006@argo.co.il>
Date: Fri, 28 Apr 2006 14:30:20 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Davi Arnaut <davi.lkml@gmail.com>, Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@ilport.com.ua>, dtor_core@ameritech.net,
       Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua> <20060427201531.GH13027@w.ods.org> <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com> <4451E185.9030107@argo.co.il> <mj+md-20060428.105455.7620.atrey@ucw.cz>
In-Reply-To: <mj+md-20060428.105455.7620.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 11:30:31.0826 (UTC) FILETIME=[2888EF20:01C66AB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Maybe continuing to write application programs in C instead of using
> higher-level languages is silly and backward, but _stopping_ at the
> level of C++ or C# is equally silly.
>
>   

Agree. Look at how well mercurial turned out compared to git, and it is 
written in such a slow language.

The high level language allows you to concentrate on the algorithms 
which is where the performance comes from.

> However, in the kernel space the main problems the people are spending
> their time with are rarely related to the language.
>   

If you're using a more productive language, you get more things done, in 
userspace and in the kernel.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

