Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbVJERVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVJERVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVJERVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:21:10 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:15496 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030274AbVJERVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:21:08 -0400
Subject: Re: [PATCH 5/7] Fragmentation Avoidance V16: 005_fallback
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0510051815370.16421@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	 <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
	 <1128531115.26009.32.camel@localhost>
	 <Pine.LNX.4.58.0510051815370.16421@skynet>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:20:59 -0700
Message-Id: <1128532859.26009.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 18:16 +0100, Mel Gorman wrote:
> 
> +               reserve_type=RCLM_NORCLM;
> 
> (Ignore the whitespace damage, cutting and pasting just so you can see
> it)

Sorry, should have been more specific.  You need spaces around the '='.

-- Dave

