Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWGZVNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWGZVNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWGZVNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:13:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28123
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751630AbWGZVNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:13:10 -0400
Date: Wed, 26 Jul 2006 14:13:23 -0700 (PDT)
Message-Id: <20060726.141323.81310974.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: takis@issaris.org, linux-kernel@vger.kernel.org
Subject: Re: Unreachable e-mailaddresses in maintainers file
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060726163730.GB6868@flint.arm.linux.org.uk>
References: <44C4D835.5010500@issaris.org>
	<20060726163730.GB6868@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 26 Jul 2006 17:37:30 +0100

> On Mon, Jul 24, 2006 at 04:24:53PM +0200, Panagiotis Issaris wrote:
> > The following two e-mailaddresses were unreachable for me:
> >...
> > rmk+mmc@arm.linux.org.uk
> 
> Bah, doesn't take long for folk to start whinging about unreachable
> email addresses. ;(

I was one keystroke away from removing you from all of the
vger.kernel.org lists because I was getting "5 day timeout"
bounces which usually means I'll be getting 5 more days of
bounces if I delete the subscription right now. :)

If you are going away for a vaction, have appropriate backup MX
records in place to queue your mail if your primary mail server goes
down.  I've crashed my primary mail server remotely to test new
kernels on several occaisions while I was on the other side of the
planet, and my backup MX made that a non-issue.

Take care.

