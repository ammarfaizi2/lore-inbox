Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUJ0ACt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUJ0ACt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUJ0ACt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:02:49 -0400
Received: from siaag1ae.compuserve.com ([149.174.40.7]:5103 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261567AbUJ0ACl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:02:41 -0400
Date: Tue, 26 Oct 2004 20:00:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: My thoughts on the "new development model"
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Massimo Cetra <mcetra@navynet.it>
Message-ID: <200410262002_MC3-1-8D38-C078@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 at 10:37:06 -0700 William Lee Irwin III wrote:

>>  "It works for me" doesn't cut it in the OS world.
>
> It's an existence proof spanning a wide swath of architectures. If
> you are not seeing similar results, send bugreports.

  I don't neeed to send in bug reports, there are plenty on l-k
right now:

  - LVM is currently broken in 2.6.9-mm1
  - the RTC and NMI code have a race condition between them
  - NFS mount won't accept a FQDN over 50 bytes (patch was
    sent and utterly ignored, then recently reposted)
  - cdrom driver thinks non-mt. rainier drives are capable


> Point releases are in fact updated and maintained. Those updates
> are given the name of the next point release.

  Are you saying people who encounter bugs in 2.6.9 should wait for
2.6.10?  ...and when they find bugs in _that_ release they should keep
waiting?  In other words, Zeno was right after all?


--Chuck Ebbert  26-Oct-04  17:23:57
