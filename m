Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314126AbSDVMDO>; Mon, 22 Apr 2002 08:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314129AbSDVMDN>; Mon, 22 Apr 2002 08:03:13 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45490 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314126AbSDVMDN>; Mon, 22 Apr 2002 08:03:13 -0400
Date: Mon, 22 Apr 2002 17:36:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: davem@redhat.com
Cc: marcelo@conectiva.br, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TRIVIAL 2.4.19-pre7: smp_call_function not allowed from bh
Message-ID: <20020422173617.A19103@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20020421.231615.129368238.davem@redhat.com> David S. Miller wrote:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Mon, 22 Apr 2002 13:35:34 +1000

> It would be nice to fix this up on every other smp_call_function
> implementation too.  Since this patch is by definition trivial, it
> would be equally trivial to make sure every platform is updated
> properly as well.

Unless Rusty has already done this, I can submit another patch
that covers all the archs.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
