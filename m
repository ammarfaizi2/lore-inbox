Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSEZI7D>; Sun, 26 May 2002 04:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315878AbSEZI7C>; Sun, 26 May 2002 04:59:02 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:53988 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315870AbSEZI7B>; Sun, 26 May 2002 04:59:01 -0400
To: Robert Schwebel <robert@schwebel.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)] 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: Your message of "Sun, 26 May 2002 10:05:39 +0200."
             <20020526100539.M598@schwebel.de> 
Date: Sun, 26 May 2002 10:58:44 +0200
Message-Id: <20020526085849.017E311972@denx.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020526100539.M598@schwebel.de> Robert Schwebel wrote:
>
> recently and there are surely things left which have to be cleaned up. It
> is common agreement between the RTAI team that patches and schedulers are
> GPL, self-developed services are LGPL. 

And to get this right: that fact that the "other"  parts  are  LGPLed
does  not  mean  that  the  RTAI team wants to keep it secret Cor put
restritctions on use - on contrary, we want  to  provide  RTAI  users
ADDITIONAL freedom - the freedom of the decision if they want to make
their application code GPLed or not.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As far as we know, our computer has never had an undetected error.
		                                           -- Weisert
