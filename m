Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUAUHJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 02:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUAUHJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 02:09:49 -0500
Received: from [66.35.79.110] ([66.35.79.110]:20611 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261931AbUAUHJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 02:09:48 -0500
Date: Tue, 20 Jan 2004 23:09:39 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: vatsa@in.ibm.com, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040121070939.GB31807@hockin.org>
References: <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org> <20040121093633.A3169@in.ibm.com> <400DFC8B.7020906@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400DFC8B.7020906@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 03:14:03PM +1100, Nick Piggin wrote:
> Or doesn't anybody care to think about hoplug scripts failing?
> (serious question)

If hotplug scripts are failing, you're in really deep trouble.  I can't find
a single case where a hotplug script failing would not indicate some other
larger failure.
