Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315016AbSDWCYx>; Mon, 22 Apr 2002 22:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315015AbSDWCYw>; Mon, 22 Apr 2002 22:24:52 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:43269 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315016AbSDWCYS>; Mon, 22 Apr 2002 22:24:18 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: marcelo@conectiva.br, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TRIVIAL 2.4.19-pre7: smp_call_function not allowed from bh 
In-Reply-To: Your message of "Mon, 22 Apr 2002 17:36:17 +0530."
             <20020422173617.A19103@in.ibm.com> 
Date: Tue, 23 Apr 2002 12:27:34 +1000
Message-Id: <E16zq1n-0002mA-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020422173617.A19103@in.ibm.com> you write:
> 
> In article <20020421.231615.129368238.davem@redhat.com> David S. Miller wrote
:
> >    From: Rusty Russell <rusty@rustcorp.com.au>
> >    Date: Mon, 22 Apr 2002 13:35:34 +1000
> 
> > It would be nice to fix this up on every other smp_call_function
> > implementation too.  Since this patch is by definition trivial, it
> > would be equally trivial to make sure every platform is updated
> > properly as well.
> 
> Unless Rusty has already done this, I can submit another patch
> that covers all the archs.

Nope, send me all the archs.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
