Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263316AbVCKOOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbVCKOOk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVCKOOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:14:39 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:17633 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S263323AbVCKOOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:14:10 -0500
Date: Fri, 11 Mar 2005 09:13:40 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for GEODE CPUs
Message-ID: <20050311141340.GF17865@csclub.uwaterloo.ca>
References: <200503081935.j28JZ433020124@hera.kernel.org> <1110387668.28860.205.camel@localhost.localdomain> <20050309173344.GD17865@csclub.uwaterloo.ca> <1110405563.3072.250.camel@localhost.localdomain> <422F8623.4030405@cantab.net> <1110413198.3116.278.camel@localhost.localdomain> <20050310174206.6b2f27b8.akpm@osdl.org> <1110538950.15927.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110538950.15927.15.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 11:02:33AM +0000, Alan Cox wrote:
> Either revert it or make it Geode GX and correct the options set. I've
> no problem with a Geode option that sets the right options 8)

Maybe it should say GX1 unless someone is sure the GX1 and GX2 (now GX
xxx@x.xW it seems) like the same optimizations.  The SCx200 could go in
the help text to clarify that those too are GX1 based.

Len Sorensen
