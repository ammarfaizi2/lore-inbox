Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQJ3BIj>; Sun, 29 Oct 2000 20:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129214AbQJ3BIa>; Sun, 29 Oct 2000 20:08:30 -0500
Received: from dibbler.ne.mediaone.net ([24.218.56.247]:10510 "EHLO
	dibbler.ne.mediaone.net") by vger.kernel.org with ESMTP
	id <S129148AbQJ3BIU>; Sun, 29 Oct 2000 20:08:20 -0500
Date: Sun, 29 Oct 2000 20:08:18 -0500
From: Craig Rodrigues <rodrigc@mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: POSIX message queue support in Linux kernel?
Message-ID: <20001029200818.A6164@mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does the Linux kernel support POSIX message queues as defined by
the Single Unix Specification, v2, ie.
http://www.opengroup.org/onlinepubs/007908799/xsh/mqueue.h.html

stuff like mq_open(), mq_send(), mq_close(), etc.

I've tried grepping the sources for 2.4.0, and could not find anything.

I noticed that RTLinux seems to support it, in a header file
called rtl_nfifo.h, in their distribution.

Are there any plans to introduce POSIX message queues in the base-line
Linux kernel?

Thanks.
-- 
Craig Rodrigues        
http://www.gis.net/~craigr    
rodrigc@mediaone.net          
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
