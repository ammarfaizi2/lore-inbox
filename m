Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUESODY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUESODY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUESODY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:03:24 -0400
Received: from sccmmhc91.asp.att.net ([204.127.203.211]:17062 "EHLO
	sccmmhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S264165AbUESODX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:03:23 -0400
Date: Wed, 19 May 2004 09:03:10 -0500 (EST)
Message-Id: <20040519.090310.38302010.wscott@bitmover.com>
To: scole@lanl.gov
Cc: mason@suse.com, hugh@veritas.com, nickpiggin@yahoo.com.au,
       elenstev@mesatop.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       support@bitmover.com, adi@bitmover.com, akpm@osdl.org,
       wli@holomorphy.com, andrea@suse.de, lm@bitmover.com
Subject: Re: 1352 NUL bytes at the end of a page?
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <BEA1FF76-A99C-11D8-A7EA-000A95CC3A8A@lanl.gov>
References: <70C69E3C-A998-11D8-A7EA-000A95CC3A8A@lanl.gov>
	<1084973802.27142.14.camel@watt.suse.com>
	<BEA1FF76-A99C-11D8-A7EA-000A95CC3A8A@lanl.gov>
X-Mailer: Mew version 4.0.64 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Cole <scole@lanl.gov>
>  But I think the results are already known;
> reiserfs opens a can of whoopass for this kind of load.

I can confirm that bk really likes reiserfs.

-Wayne
