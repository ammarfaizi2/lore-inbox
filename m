Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUFXTOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUFXTOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFXTNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:13:20 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:41706 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265293AbUFXTMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:12:14 -0400
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200406241912.i5OJC1X03468@dbear.engr.sgi.com>
Subject: Re: [PATCH] Process Aggregates (PAGG) for 2.6.7
To: chrisw@osdl.org (Chris Wright)
Date: Thu, 24 Jun 2004 12:12:01 -0700 (PDT)
Cc: erikj@subway.americas.sgi.com (Erik Jacobson),
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, limin@engr.sgi.com,
       pwil3058@bigpond.net.au
In-Reply-To: <20040624115704.O22989@build.pdx.osdl.net> from "Chris Wright" at Jun 24, 2004 11:57:04 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, this is really ioctl.  This should be exposed in fs interface, or
> the primitives should be promoted to first class syscalls if others can
> use this.

Yes, that would be better. 

But right now, we only have CSA ( Comprehensive System Accounting) use 
job, :)

--Limin

> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> 

