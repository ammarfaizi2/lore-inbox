Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUFRAox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUFRAox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUFRAox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:44:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4010 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264893AbUFRAov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:44:51 -0400
Date: Fri, 18 Jun 2004 01:44:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk>
References: <40D232AD.4020708@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D232AD.4020708@opensound.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 05:09:17PM -0700, 4Front Technologies wrote:
> Hi Folks,
> 
> I am writing this message to bring a huge problem to light. SuSE has been 
> systematically
> forking the linux kernel and shipping all kinds of modifications and still 
> call their
> kernels 2.6.5 (for example).
> 
> Either they ship the stock Linux kernel sources or they stop calling their 
> distributions
> as Linux-2.6.x based.
> 
> Kernel headers are being changed willy-nilly and SuSE are completely 
> running rough-shod
> over the linux kernel with the result ONLY software from SuSE works.

"Software" == "3rd-party kernel modules" in this case, right?

Remember what had been told to you about in-kernel interfaces?  That's
right, that they can be changed at zero notice.  Now, if SuSE told you
otherwise, you might have a cause to complain.  Had they?

If they'd promised in-kernel interface stability and lied - sure, go ahead
and nail them to the wall.  If not - STFU and eat what you are bloody given.

Al, not particulary fond of SuSE, but even less so - of misdirecting wankers
like that...
