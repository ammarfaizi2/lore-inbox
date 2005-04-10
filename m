Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVDJRvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVDJRvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVDJRvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:51:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44726 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261539AbVDJRvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:51:35 -0400
Date: Sun, 10 Apr 2005 10:50:03 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: junkio@cox.net, dlang@digitalinsight.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050410105003.10e49ea0.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.3.96.1050410124238.18440A-100000@gatekeeper.tmr.com>
References: <7vzmw7as25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.3.96.1050410124238.18440A-100000@gatekeeper.tmr.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's possible to generate another object with the same hash, but:

Yeah - the real check is that the modified object has to
compile and do something useful for someone (the cracker
if no one else).

Just getting a random bucket of bits substituted for a
real kernel source file isn't going to get me into the
cracker hall of fame, only into their odd-news of the
day.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
