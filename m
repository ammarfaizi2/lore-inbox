Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273057AbRIIVTb>; Sun, 9 Sep 2001 17:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273058AbRIIVTU>; Sun, 9 Sep 2001 17:19:20 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:7120 "EHLO
	inet-mail4.oraclecorp.com") by vger.kernel.org with ESMTP
	id <S273057AbRIIVTK>; Sun, 9 Sep 2001 17:19:10 -0400
Message-ID: <3B9BDD7C.78B58344@oracle.com>
Date: Sun, 09 Sep 2001 23:22:04 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Josh McKinney <forming@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: compiling kernel with gcc-3 (was: 2.4.10-pre5)
In-Reply-To: <E15fhnT-0003np-00@the-village.bc.nu> <3B9A95C7.DDF81890@oracle.com> <20010908230539.A4927@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh McKinney wrote:
> 
> Since I have gotten a decent amount of flame mail from my one-liner posted
> yesterday, I am just curious.  Has anyone really been able to successfully
> compile their kernel with gcc-3*.  I did once or twice long before it was
> released, but it dies on the same error everytime.  I posted it to the
> GCC mailing list because it was an internal compiler error, but it went
> unanswered, along with other reports of the same bug.  Anyway, I just want
> to see if someone really is able to use it as a reliable compiler.
> 

I've been compiling kernels since June 22 with 3.0, never a
 problem. -pre5 and -pre6 compiled with 3.0.1 backing out the
 rd.c changes.

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
