Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTD1Wa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTD1Wa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:30:59 -0400
Received: from holomorphy.com ([66.224.33.161]:27336 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261374AbTD1Wa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:30:58 -0400
Date: Mon, 28 Apr 2003 15:43:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andi Kleen <ak@suse.de>, Henti Smith <bain@tcsn.co.za>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428224301.GX30441@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Andi Kleen <ak@suse.de>, Henti Smith <bain@tcsn.co.za>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	Riley Williams <Riley@Williams.Name>
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <3EAD5D90.7010101@gmx.net> <3EAD61FB.30907@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD61FB.30907@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 10:16:43AM -0700, Dave Hansen wrote:
> Nobody knows how far it will go.  It's fairly safe to say that, at this
> rate, Linux will keep up with whatever hardware anyone produces.
> Unless, of course, someone gets even more perverse than PAE. :)

32-bit kernels on 64-bit machines with RAM capacities larger than 64GB
would seem to raise issues far more severe than i386 PAE, but to date
little (if any) interest has been expressed in using Linux in such
scenarios.


-- wli
