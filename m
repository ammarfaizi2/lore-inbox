Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbQKFQvk>; Mon, 6 Nov 2000 11:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKFQva>; Mon, 6 Nov 2000 11:51:30 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:57869 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129049AbQKFQvW>; Mon, 6 Nov 2000 11:51:22 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA25698F.005C921F.00@d73mta05.au.ibm.com>
Date: Mon, 6 Nov 2000 16:04:53 +0530
Subject: to resize shared memory segment by using shmctl
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
is it possible to change the size of a preexisting shared memory segment by
using shmctl?

AIX has comand  SHM_SIZE to shmctl to resize any existing shared memory
segment.
can it be done without recreating the whole thing in linux?

thanks
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
