Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSJYUPv>; Fri, 25 Oct 2002 16:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJYUPv>; Fri, 25 Oct 2002 16:15:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14755 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261579AbSJYUPu>;
	Fri, 25 Oct 2002 16:15:50 -0400
Message-ID: <3DB9A625.7CFAFA66@us.ibm.com>
Date: Fri, 25 Oct 2002 13:14:29 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>
		<3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com> 
		<3DB880E8.747C7EEC@us.ibm.com> <1035555715.3447.150.camel@plars> 
		<3DB97C90.2DF810E6@us.ibm.com> <1035570043.5646.191.camel@plars> 
		<3DB992B7.E8919930@us.ibm.com> <1035572820.5646.211.camel@plars>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> I havn't seen this test fail before but I'll be happy to do more testing
> with your patch to see if I can reproduce it.  You may also want to
> consider updating LTP to the newest version.  I'm fairly certain that
> shmctl01 hasn't been changed since the version you have, but just to be
> consistent you may want to do that.
> 
Ha! Sorry about the confusion.  I re-install ltp test suites and the
error is gone. My old tests must be dirty.

Mingming
