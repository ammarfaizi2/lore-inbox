Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbUJZMhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbUJZMhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUJZMhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:37:47 -0400
Received: from gold.pobox.com ([208.210.124.73]:4569 "EHLO gold.pobox.com")
	by vger.kernel.org with ESMTP id S262247AbUJZMhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:37:43 -0400
Date: Tue, 26 Oct 2004 05:37:27 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Ed Tomlinson <edt@aei.ca>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041026123727.GA9375@ip68-4-98-123.oc.oc.cox.net>
References: <200410260142_MC3-1-8D2A-45C2@compuserve.com> <200410260644.47307.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410260644.47307.edt@aei.ca>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 06:44:46AM -0400, Ed Tomlinson wrote:
> To my mind this just points out the need for a bug fix branch.   e.g. a
> branch containing just bug/security fixes against the current stable
> kernel.  It might also be worth keeping the branch active for the n-1
> stable kernel too.
> 
> Ed
> 
> PS.  we could call this the Bug/Security or bs kernels.

The current kernel version number scheme already has a provision for
a security/bug fix branch: 2.6.9.1, 2.6.9.2, etc.

-Barry K. Nathan <barryn@pobox.com>

