Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290000AbSAWToY>; Wed, 23 Jan 2002 14:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290010AbSAWToP>; Wed, 23 Jan 2002 14:44:15 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1299 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290000AbSAWTn5>; Wed, 23 Jan 2002 14:43:57 -0500
Message-ID: <3C4F10F9.87A3B2E@zip.com.au>
Date: Wed, 23 Jan 2002 11:37:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: Low latency for recent kernels
In-Reply-To: <20020123091643.A182@earthlink.net> <3C4F0DFA.50601@lexus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> Ditto here -
> 

Yes, sorry about that.  That patch had a completely untested,
experimental and buggy chunk in it which kinda escaped from the
factory.

I've uploaded a saner version.

-
