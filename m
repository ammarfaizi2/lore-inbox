Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUBMVqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267233AbUBMVqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:46:49 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:9871 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267230AbUBMVqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:46:48 -0500
Date: Fri, 13 Feb 2004 22:46:46 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling
Message-ID: <20040213214646.GB32006@MAIL.13thfloor.at>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040213205743.GA30245@MAIL.13thfloor.at.suse.lists.linux.kernel> <p73n07my8nn.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73n07my8nn.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 10:25:00PM +0100, Andi Kleen wrote:
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> > 	[ARCH sparc64/sparc]    failed.     failed.
> > 	[ARCH x86_64/x86_64]    failed.     succeeded.
> 
> Your test methology must be broken. 2.4.25rc2 cross compiles 
> just fine here from i386 to x86_64. 

might be, but if, where is it broken ...
(if you need any information, let me know)

started a testrun for 2.4.25-rc2 a few minutes
ago, and will make the results as well as the
detailed build logs available when it completes
(takes some time, about 40-60 mins)

TIA,
Herbert

> -Andi
