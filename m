Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUCDIfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUCDIfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:35:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:59520 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261545AbUCDIfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:35:47 -0500
Date: Thu, 4 Mar 2004 00:35:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How to black list shared libraries and executable
Message-ID: <20040304003546.U22989@build.pdx.osdl.net>
References: <opr4bsvwbj4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <opr4bsvwbj4evsfm@smtp.pacific.net.th>; from mhf@linuxmail.org on Thu, Mar 04, 2004 at 03:10:34PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Frank (mhf@linuxmail.org) wrote:
> Just wondering on how to build a kernel-level facility which would
> require shared libraries and executables to be "keyed" or even
> "signed" to run on linux.

Take a look at Cryptomark or DigSig.  They at least cover the
executables bit.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
