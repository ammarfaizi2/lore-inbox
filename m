Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSGMSzf>; Sat, 13 Jul 2002 14:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSGMSzf>; Sat, 13 Jul 2002 14:55:35 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:46552 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315282AbSGMSze>; Sat, 13 Jul 2002 14:55:34 -0400
Date: Sat, 13 Jul 2002 14:57:23 -0400
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: oprofile results with lmbench
Message-ID: <20020713185723.GA17787@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oprofile gives access to cpu performance counters on x86.

I ran oprofile with the individual lmbench tests to get
data from several of the counters.  This "hot kernel 
function" and counter info may be useful.  A web page with the
results from 5 of the performance counters for each
lmbench test is at:

http://home.earthlink.net/~rwhron/kernel/lmbench_oprofile.html

I'll add the rest of the counter data over the next few days.
Comments/caveats on how to make the information more useful are
welcome.

The target kernel was 2.4.19rc1aa1 on an Athlon 1333.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

