Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310405AbSCBQ6r>; Sat, 2 Mar 2002 11:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310404AbSCBQ6i>; Sat, 2 Mar 2002 11:58:38 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:64243 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S310402AbSCBQ6Z>; Sat, 2 Mar 2002 11:58:25 -0500
To: root@chaos.analogic.com
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Matthew Allum <mallum@xblox.net>, linux-kernel@vger.kernel.org
Subject: Re: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
In-Reply-To: <Pine.LNX.3.95.1020301123724.5515A-100000@chaos.analogic.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.LNX.3.95.1020301123724.5515A-100000@chaos.analogic.com>
Date: 02 Mar 2002 04:53:23 +0100
Message-ID: <m24rjzy6a4.fsf@anano.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "richard" == Richard B Johnson <root@chaos.analogic.com> writes:

Hi

richard> Once somebody makes a kernel they has both a working loop device and
richard> a working initial RAM Disk, I will use that kernel. In the meantime,
richard> I'm stuck at 2.4.1.

I am not sure what you are doing, and I don't remeber seing your
script to reproduce the problem, but I can confirm you that:
- loop device works
- initrd works

We used it for Mandrake kernels, and it works with SCSI without any
problems.  Could you send me your script to create the intrd to me to
take a look?

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
