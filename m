Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWHSBEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWHSBEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 21:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWHSBEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 21:04:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48138 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422698AbWHSBEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 21:04:39 -0400
Date: Sat, 19 Aug 2006 03:04:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Open ext3 bugs in the kernel Bugzilla
Message-ID: <20060819010438.GG7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that many people seem to enjoy the fun of creating an ext4 with many 
new features, it seems to be a good time for finding people who'd like 
to review the 16 open ext3 bugs in the kernel Bugzilla [1] before the 
code bases of ext3 and ext4 start diverging.  ;-)

Any volunteers?

cu
Adrian

[1] http://bugzilla.kernel.org/buglist.cgi?component=ext3&bug_status=NEW&bug_status=ASSIGNED&bug_status=VERIFIED&bug_status=DEFERRED&bug_status=NEEDINFO

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

