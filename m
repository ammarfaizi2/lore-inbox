Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135523AbRDWTq6>; Mon, 23 Apr 2001 15:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135528AbRDWTqs>; Mon, 23 Apr 2001 15:46:48 -0400
Received: from [194.46.8.33] ([194.46.8.33]:36626 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S135523AbRDWTqj>;
	Mon, 23 Apr 2001 15:46:39 -0400
Date: Mon, 23 Apr 2001 20:48:27 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Has the iptables security patch been vetted?
Message-ID: <20010423204825.H26083@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure you've run across this one:

	http://netfilter.samba.org/security-fix/

I'd like to know how official this patch is, ie how
well checked out? I'd hardly want to cure one problem
and create another. And I'm uncomfortable with it at
first glance: I'd have to find figure out why it is
returning immediate success at that point, or rather
prove to myself that it is just skipping making the
bad table entries.

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------
