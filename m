Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUHMRNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUHMRNf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHMRNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:13:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:56803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266244AbUHMRLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:11:40 -0400
Date: Fri, 13 Aug 2004 10:11:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: chrisw@osdl.org, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small simplification for two SECURITY dependencies
Message-ID: <20040813101137.R1924@build.pdx.osdl.net>
References: <20040812211916.GO13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040812211916.GO13377@fs.tum.de>; from bunk@fs.tum.de on Thu, Aug 12, 2004 at 11:19:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@fs.tum.de) wrote:
> 
> I'd suggest the patch below to let the SECURITY_CAPABILITIES and 
> SECURITY_ROOTPLUG dependencies look a bit more simple.

I agree, can push this up today with a couple other outstanding changes I
have.  Thank you.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
