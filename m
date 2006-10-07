Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWJGROA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWJGROA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWJGROA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:14:00 -0400
Received: from main.gmane.org ([80.91.229.2]:57572 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932157AbWJGRN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:13:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: 25 random kernel configs, 24 build failures - 2.6.19-rc1-git2
Date: Sat, 7 Oct 2006 17:13:30 +0000 (UTC)
Message-ID: <loom.20061007T185916-369@post.gmane.org>
References: <200610071102.05384.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.61.60.54 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1; .NET CLR 1.1.4322))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl <at> gmail.com> writes:


> kernel/sched.c: In function `domain_distance':
> kernel/sched.c:5673: internal compiler error: Segmentation fault
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://gcc.gnu.org/bugs.html> for instructions.
> make[1]: *** [kernel/sched.o] Error 1
> make: *** [kernel] Error 2
> 
> ====================

Jesper

In case you haven't noticed this in the load of errors - there you have 
something to report to GCC bugzilla! (I did a quick gcc bugzilla search for 
kernel/sched.c and ICE, but did not see anything exactly similar at the least.)

Parag

