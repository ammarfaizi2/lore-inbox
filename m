Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265004AbSJWN5q>; Wed, 23 Oct 2002 09:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbSJWN5q>; Wed, 23 Oct 2002 09:57:46 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:48596 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265004AbSJWN5p>; Wed, 23 Oct 2002 09:57:45 -0400
Message-ID: <3DB6AC40.20007@nortelnetworks.com>
Date: Wed, 23 Oct 2002 10:03:44 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Slavcho Nikolov <snikolov@okena.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: feature request - why not make netif_rx() a pointer?
References: <20021023003959.GA23155@bougret.hpl.hp.com> <004c01c27a99$927b8a30$800a140a@SLNW2K>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slavcho Nikolov wrote:


> As for GPL, I hope that commercial enterprises be allowed to utilize
> business models
> which do not necessarily consist in providing services around free software.
> The more replaceable hooks you provide to filesystems and network stacks,
> the better.

I don't think you understand the nature of the GPL and linux development.

The kernel developers do not have any obligation to anything other than 
technical excellence.  You're getting a highly optimized operating 
system *at no financial cost*.  In return, the community requires that 
certain types of modifications be made publicly available.

If you want to replace the messaging code, make a GPL'd kernel patch and 
make it available to your clients (of course they can then publish it 
all over the place if they so desire).  If those terms are not 
acceptable, there's always BSD.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

