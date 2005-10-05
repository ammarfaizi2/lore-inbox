Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbVJERc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVJERc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVJERc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:32:29 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:62617 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030284AbVJERc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:32:29 -0400
Date: Wed, 5 Oct 2005 18:32:27 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH 5/7] Fragmentation Avoidance V16: 005_fallback
In-Reply-To: <1128532859.26009.41.camel@localhost>
Message-ID: <Pine.LNX.4.58.0510051831270.16421@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie> 
 <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie> 
 <1128531115.26009.32.camel@localhost>  <Pine.LNX.4.58.0510051815370.16421@skynet>
 <1128532859.26009.41.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Dave Hansen wrote:

> On Wed, 2005-10-05 at 18:16 +0100, Mel Gorman wrote:
> >
> > +               reserve_type=RCLM_NORCLM;
> >
> > (Ignore the whitespace damage, cutting and pasting just so you can see
> > it)
>
> Sorry, should have been more specific.  You need spaces around the '='.
>

Ah. It's now added to my growing list of "Highlight bad style in red"
list of vim macros. Sholdn't happen again.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
