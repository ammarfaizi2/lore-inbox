Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277720AbRJIFP6>; Tue, 9 Oct 2001 01:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277722AbRJIFPs>; Tue, 9 Oct 2001 01:15:48 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:41707 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S277720AbRJIFPg>;
	Tue, 9 Oct 2001 01:15:36 -0400
Message-ID: <3BC28816.CA6377AD@candelatech.com>
Date: Mon, 08 Oct 2001 22:16:06 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Simple question on files & sockets in kernel space.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to be able to read/write a file in the
regular file system (like /tmp/mystuff.txt) from the
kernel space.  In user-space, I'd use open() and then
read() and write().  Can someone suggest a piece of kernel
code or documentation that does something like this?

I would also like to get a TCP/IP socket and read/write
to it in a similar manner.  Basically, I want the familiarity
of user-space, but I have to implement most of the functionality
in the kernel.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
