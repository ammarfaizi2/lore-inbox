Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129376AbQJ0Pdb>; Fri, 27 Oct 2000 11:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbQJ0PdW>; Fri, 27 Oct 2000 11:33:22 -0400
Received: from mail2.lycos.com ([208.146.26.19]:6113 "EHLO mail2.lycos.com")
	by vger.kernel.org with ESMTP id <S129448AbQJ0PdM>;
	Fri, 27 Oct 2000 11:33:12 -0400
X-Lotus-FromDomain: LYCOS
From: jpranevich@lycos-inc.com
To: linux-kernel@vger.kernel.org
Message-ID: <85256985.00556CD3.00@SMTPNotes1.ma.lycos.com>
Date: Fri, 27 Oct 2000 11:30:32 -0400
Subject: Big file support in Linux 2.2
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

For one of our projects here, we've crashed head first into the 2 gig file size
limitation in Linux 2.2 kernels. While I know that this has been solved in
2.3/2.4, has there been any work to backport this feature into a Linux 2.2
kernel? I'm looking for a temporary solution until we can move to Linux 2.4
directly, but obviously not until after it's been "really" released. :)

Yes, I know this is likely to be relatively unstable. (Probably almost as
unstable as running a 2.4-pre kernel in production), but at least it would give
us a start.

Thanks for your help,

Joe


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
