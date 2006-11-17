Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424836AbWKQPkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424836AbWKQPkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424832AbWKQPkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:40:25 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:22761 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1424836AbWKQPkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:40:23 -0500
Date: Fri, 17 Nov 2006 16:40:21 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: NFSROOT with NFS Version 3
Message-Id: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; sparc-sun-solaris2.8)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to switch an NFSROOT-Environment from NFS version 2 to NFS
version 3, but unfortunately my test client machine now hangs every time
after booting as soon as some bigger file system activity should occur.
I tried Kernel 2.6.14.7 and Kernel 2.6.16.32.

The problem did not occur with NFS version 2.

Does anybody know the problem and/or a solution?

Regards
  Christoph Pleger
