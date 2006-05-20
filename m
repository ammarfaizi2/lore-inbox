Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWETUe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWETUe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWETUe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 16:34:58 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:63148 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751482AbWETUe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 16:34:57 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=CheEfr0DcFDT7cB54Rx0L4R5Ab+bpBcOdHvCaxBJ6rg6zHSLqclRmDuOsWnY7lAUla+tqEy92vSnKOYnMTTn6xD4lHJd6xvqsipIJkntg9DlKXe/K4dd3LtmAyAeorSI;
X-IronPort-AV: i="4.05,150,1146459600"; 
   d="scan'208"; a="16967986:sNHT27182016"
Date: Sat, 20 May 2006 15:34:59 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (take #2)] EDD isn't EXPERIMENTAL anymore
Message-ID: <20060520203459.GA30691@lists.us.dell.com>
References: <20060520025255.GB9486@taniwha.stupidest.org> <20060520035310.GA28977@humbolt.us.dell.com> <20060520040620.GA11109@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520040620.GA11109@taniwha.stupidest.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 09:06:20PM -0700, Chris Wedgwood wrote:
> Oops.
> 
> Resend with Kconfig comment change too.  It also occured to me that
> !IA64 is a lousy check, EDD is really i386 and x86_64 only, it's
> clearly not useful for ppc, alpha, etc.
> 
> Would anyone object to a chance for that too?

No objection here.  I'm only aware of it working on i386 and x86_64.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
