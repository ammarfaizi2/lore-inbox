Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSDCHDo>; Wed, 3 Apr 2002 02:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293187AbSDCHDe>; Wed, 3 Apr 2002 02:03:34 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:44261 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S293132AbSDCHDY>;
	Wed, 3 Apr 2002 02:03:24 -0500
Date: Wed, 3 Apr 2002 08:00:31 +0100
Message-Id: <200204030700.g3370VO01976@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: "Axel H. Siebenwirth" <axel@hh59.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Another BUG in page_alloc.c:108
In-Reply-To: <20020403035406.GA2925@neon>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020403035406.GA2925@neon> you wrote:
> EIP:    0010:[__free_pages_ok+45/688]    Tainted: P 

Nvidia ? 
I get the distinct impression that the lastest nvidia drivers
reintroduced a bug that fubars the page allocator ;(


