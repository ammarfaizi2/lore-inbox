Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVDASWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVDASWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVDASWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:22:23 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:61897 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262701AbVDASWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:22:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=I3q14gzK6DwtXpqOSRx9kf1/JZTphyDC1SNpE3SweopTnjoI60IK4v5bj8B5wed0lm++brNgVYMpICcGCJ2XJnO6rF6GKfdeakEnN7cTCxTOktHC1I19zJbzJUOB4JA8RkUi3K3oErULxum0OA4tUlEkywTyFCndtqZribE1SkI=
Message-ID: <1c55c94505040110224ea1ebb6@mail.gmail.com>
Date: Fri, 1 Apr 2005 11:22:20 -0700
From: Grecko OSCP <grecko.lists@gmail.com>
Reply-To: Grecko OSCP <grecko.lists@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel Performance Testing
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,

I noticed yesterday a news article on Linux.org about more kernel
performance testing being called for, and I decided it would be a nice
project to try. I have 10 completely identical systems that can be
used for this, and would like to get started while I know I have them
for a while.

However, I wanted to make sure I didn't waste time. My plan was to do
all testing, prerelease, and release kernels from the 2.4, 2.5, and
2.6 trees, with both lmbench and the Linux Testing Project (LTP)
benchmark suite. Will this help out? Is there anything else a person
should do? With those two benchmarks, and all the kernels I mentioned,
I could be done in about 25 days, at one kernel a machine a day. I
assume it wouldn't matter what distribution was used, so long as its
the same for all tests?

Thanks!
Grecko
