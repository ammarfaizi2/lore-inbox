Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUH0QTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUH0QTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUH0QTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:19:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:38543 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266484AbUH0QSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:18:55 -0400
Subject: Re: 2 New compile/sparse warnings (nightly build)
From: John Cherry <cherry@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040827152551.GI21964@parcelfarce.linux.theplanet.co.uk>
References: <1093619350.2467.17.camel@cherrybomb.pdx.osdl.net>
	 <20040827152551.GI21964@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1093623270.2468.47.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 27 Aug 2004 09:14:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Build was with allmodconfig on i386 arch.

On Fri, 2004-08-27 at 08:25, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Fri, Aug 27, 2004 at 08:09:10AM -0700, John Cherry wrote:
> > Summary:
> >    New warnings = 2
> >    Fixed warnings = 8
>  
> Hmm...  What .config are you using?  There was a bunch of sound/oss
> check_region() removals, etc.
> 
> Here I'm running builds on allmodconfig and allomodconfig with added
> 'SMP depends on BROKEN' to catch the BROKEN_ON_SMP drivers.

