Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279699AbRJYHDe>; Thu, 25 Oct 2001 03:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279715AbRJYHDV>; Thu, 25 Oct 2001 03:03:21 -0400
Received: from venus.it.swin.edu.au ([136.186.5.30]:18440 "EHLO
	venus.it.swin.edu.au") by vger.kernel.org with ESMTP
	id <S279699AbRJYHDC>; Thu, 25 Oct 2001 03:03:02 -0400
Message-ID: <3BD7B7FE.D8949E3E@it.swin.edu.au>
Date: Thu, 25 Oct 2001 16:58:06 +1000
From: John Newbigin <jn@it.swin.edu.au>
Reply-To: jn@it.swin.edu.au
Organization: Swinburne University of Technology
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en,ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: applying patches to running kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have created a patch which protects against the suid & ptrace
problem.  The patch is a kernel module which you can load into a running
kernel without the need to reboot.

It is just a concept at the moment (although it appears to work) but I
hope that it might sparc some intrest in a project devoted to simalar
kinds of 'hot' fixes.

The module code and short description can be found here
http://uranus.it.swin.edu.au/~jn/linux/kernel.htm

Please cc me in any replies.

John.

-- 
Information Technology Innovation Group
Swinburne University. Melbourne, Australia
http://uranus.it.swin.edu.au/~jn
