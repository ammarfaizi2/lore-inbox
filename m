Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263444AbRFAPT0>; Fri, 1 Jun 2001 11:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263557AbRFAPTQ>; Fri, 1 Jun 2001 11:19:16 -0400
Received: from mail.intrex.net ([209.42.192.246]:33549 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S263444AbRFAPTC>;
	Fri, 1 Jun 2001 11:19:02 -0400
Date: Fri, 1 Jun 2001 11:21:27 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Highmem Bigmem question
Message-ID: <20010601112127.A5798@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    This is probably an FAQ, but I read the FAQ and its not in there.
I have a machine with 2G of memory.  I compiled the kernel with the 4G memory
option.  How much address space should each process be able to address?  Does
this change if I use the 64G option?  I'm after 2.4 information.  Right now
I am running on a 2.2 kernel and it looks like the user processes are limited
to ~1G.

Thanks,

Jim
