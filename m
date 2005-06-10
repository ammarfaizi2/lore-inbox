Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVFJRCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVFJRCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVFJRCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:02:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262607AbVFJRCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:02:02 -0400
Date: Fri, 10 Jun 2005 10:01:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Yuri Shirman <shirman@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: computer/kernel lockup
Message-ID: <20050610170155.GE9153@shell0.pdx.osdl.net>
References: <1118421862.6161.0.camel@gaugino.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118421862.6161.0.camel@gaugino.lanl.gov>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Yuri Shirman (shirman@lanl.gov) wrote:
> I do not have an easy way to redirect this output somewhere through the
> serial port.
> 
> I would appreciate any help in either capturing the output of Alt-SysRq
> or more generally diagnosing the problem. I will recompile the kernel
> if needed for diagnostics.

Try netconsole.
