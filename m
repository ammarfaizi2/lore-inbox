Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTJOPkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTJOPkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:40:21 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:38140 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263445AbTJOPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:40:17 -0400
Date: Wed, 15 Oct 2003 17:40:17 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: LVM Snapshots
Message-Id: <20031015174017.606c6047.Christoph.Pleger@uni-dortmund.de>
Reply-To: linux-kernel@vger.kernel.org
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a 2.4.22 kernel from www.kernel.org together with an XFS
patch from SGI. I want to use LVM for creating snapshots for backups,
but I found out that I cannot mount the snapshots of journalling
filesystems (EXT3, XFS, Reiser). Only JFS snapshots can be mounted.

My research on internet gave the result that a kernel-patch must be used
to solve that problem, but I could not find such a patch for Linux
2.4.22, so where can I get it?

Kind Regards
  Christoph 

PS: I do not know if it is of interest, but my distribution is Debian
woody with LVM 1.0.
