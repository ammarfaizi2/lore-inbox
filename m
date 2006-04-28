Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWD1KDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWD1KDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWD1KDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:03:49 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:63501 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030352AbWD1KDs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:03:48 -0400
Message-ID: <4451E87D.1000102@argo.co.il>
Date: Fri, 28 Apr 2006 13:03:41 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Davi Arnaut <davi.lkml@gmail.com>
CC: Willy Tarreau <willy@w.ods.org>, Denis Vlasenko <vda@ilport.com.ua>,
       dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	 <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>	 <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>	 <20060427201531.GH13027@w.ods.org> <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com> <4451E185.9030107@argo.co.il>
In-Reply-To: <4451E185.9030107@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 10:03:47.0211 (UTC) FILETIME=[0A57B5B0:01C66AAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
>
> Kernels of other operating systems (Windows, AIX (?)) allow C++. And 
> don't start about Windows crashing whenever you sneeze at it - it's so 
> 1998.
>

Oh, and it looks like some guy even wrote a kernel [1] in C++! Lucky we 
don't have people like that working on Linux.

[1] http://www.zipworld.com.au/~akpm/#rtos


(Sorry, couldn't resist)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

