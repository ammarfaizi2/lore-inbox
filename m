Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263487AbRFAMoe>; Fri, 1 Jun 2001 08:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbRFAMoY>; Fri, 1 Jun 2001 08:44:24 -0400
Received: from garlic.amaranth.net ([216.235.243.195]:16903 "EHLO
	garlic.amaranth.net") by vger.kernel.org with ESMTP
	id <S263487AbRFAMoU>; Fri, 1 Jun 2001 08:44:20 -0400
Message-ID: <3B178E0E.A4530D47@egenera.com>
Date: Fri, 01 Jun 2001 08:43:58 -0400
From: Phil Auld <pauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Configure.help is complete
In-Reply-To: <Pine.GSO.4.21.0105311555250.17748-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

...snip...

> 
> We should start removing the crap from procfs in 2.5. Documenting shit is
> a good step, but taking it out would be better.
> 

Not to open a what may be can of worms but ...

What's wrong with procfs? 

It allows a general interface to the kernel that does not require new
syscalls/ioctls and can be accessed from user space without specifically
compiled programs. You can use shell scripts, java, command line etc.

Cheers,

Phil



------------------------------------------------------
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
