Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVJXPDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVJXPDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVJXPDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:03:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36317 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751071AbVJXPDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:03:05 -0400
Date: Mon, 24 Oct 2005 08:02:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       clameter@sgi.com, torvalds@osdl.org, ak@suse.de
Subject: Re: [PATCH 02/02] cpuset automatic numa mempolicy rebinding
Message-Id: <20051024080249.26d34da0.pj@sgi.com>
In-Reply-To: <1130165544.22707.54.camel@localhost>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
	<20051024072750.10390.32993.sendpatchset@jackhammer.engr.sgi.com>
	<1130142987.16002.4.camel@localhost>
	<20051024074738.4f2bfcbc.pj@sgi.com>
	<1130165544.22707.54.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> I really just meant it was hard to read having two braces at the same
> level.  This was due to the extra block inside of the switch() ...

Ah - yes.  That.

Such is life.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
