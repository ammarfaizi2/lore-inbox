Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUCLQrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbUCLQrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:47:31 -0500
Received: from mill.mtholyoke.edu ([138.110.30.76]:20868 "EHLO
	mill.mtholyoke.edu") by vger.kernel.org with ESMTP id S262309AbUCLQr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:47:29 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Fri, 12 Mar 2004 11:47:04 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: network/performance problem
Message-ID: <20040312164704.GA17969@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu> <20040311151559.72706624.akpm@osdl.org> <20040311233525.GA14065@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311233525.GA14065@mtholyoke.edu>
User-Agent: Mutt/1.3.28i
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick.

(I'm all set now.  Someone kindly sent me a critical network patch via
email... :)

I'm not subscribed to lkml, but am following along in fa.kernel.linux.
I'm replying to my own mail to keep the thread somewhat intact...

Anyway, sam's .config can be found here:

http://depot.mtholyoke.edu:8080/tmp/sam-profile/sam-config-2.4.21

On sam, I just did:

1002# cat /proc/net/ip_conntrack > ip_conntrack

..and it wiped the machine out.  I can't ping it, ssh to it, nothing.  I
need to go walk over to the machine room...  :(

After lunch I'm stuck in meetings for awhile...

Thanks.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
