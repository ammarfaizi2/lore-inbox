Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLUPQc>; Sat, 21 Dec 2002 10:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSLUPQc>; Sat, 21 Dec 2002 10:16:32 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:48914 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S261349AbSLUPQb>; Sat, 21 Dec 2002 10:16:31 -0500
Date: Sat, 21 Dec 2002 08:23:04 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: andersen@codepoet.org
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <4088952704.1040484184@aslan.scsiguy.com>
In-Reply-To: <20021221071031.GA25566@codepoet.org>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
 <176730000.1040430221@aslan.btc.adaptec.com>
 <20021221002940.GM25000@holomorphy.com>
 <190380000.1040432350@aslan.btc.adaptec.com>
 <20021221013500.GN25000@holomorphy.com>
 <223910000.1040435985@aslan.btc.adaptec.com>
 <20021221071031.GA25566@codepoet.org>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the latest aic7xxx driver available as, say, a unified diff,
> or a tarball, or some similar usable format?

I'm generating tarballs right now.  The problem with unified diffs is
that everyone wants them against something different.  With the tarball,
and 2.4.X, you should be able to just drop in the driver on just about
any kernel version.

--
Justin

