Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSLWE3N>; Sun, 22 Dec 2002 23:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSLWE3N>; Sun, 22 Dec 2002 23:29:13 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64232 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262913AbSLWE3M>;
	Sun, 22 Dec 2002 23:29:12 -0500
Date: Mon, 23 Dec 2002 10:04:05 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       dipankar@in.ibm.com
Subject: Re: [patch] Make rt_cache_stat use kmalloc_percpu
Message-ID: <20021223100405.B23413@in.ibm.com>
References: <20021216192212.C26076@in.ibm.com> <20021220.230528.106417474.davem@redhat.com> <3E0418EC.B55941EE@digeo.com> <20021220.232909.88324816.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021220.232909.88324816.davem@redhat.com>; from davem@redhat.com on Fri, Dec 20, 2002 at 11:29:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 11:29:09PM -0800, David S. Miller wrote:
>...    
>    Kiran's latest (vastly simpler) version looks fine to my eye.
>    
> Ok, so once that is in, he can feel free to resubmit the
> rt_cache_state patch.

Ok, I'll do that 

Thanks,
Kiran
