Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314378AbSDRPqn>; Thu, 18 Apr 2002 11:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314379AbSDRPqm>; Thu, 18 Apr 2002 11:46:42 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:34564 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314378AbSDRPqm> convert rfc822-to-8bit; Thu, 18 Apr 2002 11:46:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux on s/390 is cute
Date: Thu, 18 Apr 2002 17:46:30 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <20020418082636.O2710@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204181746.30992.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> I'd really like to see the IBM guys let the walls between the linux
> instances down a bit.  If I could mmap the other linux instances

I guess the wall between the images is more an advantage than a disadvantage. 
And for sharing information between the images you have virtual network 
drivers IUCV (VM) or hypersockets(LPAR) with a theoretical bandwith up to 
24Gbyte/sec for hypersockets.

That should be enough.....
