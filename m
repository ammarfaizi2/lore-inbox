Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVBRPbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVBRPbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVBRPbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:31:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:1437 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261208AbVBRPbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:31:33 -0500
Subject: Re: [RFC][PATCH] Sparse Memory Handling (hot-add foundation)
From: Dave Hansen <haveblue@us.ibm.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20050218051633.GA5037@w-mikek2.ibm.com>
References: <1108685033.6482.38.camel@localhost>
	 <20050218051633.GA5037@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 07:31:01 -0800
Message-Id: <1108740662.6482.53.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 21:16 -0800, Mike Kravetz wrote:
> On Thu, Feb 17, 2005 at 04:03:53PM -0800, Dave Hansen wrote:
> > The attached patch
> 
> Just tried to compile this and noticed that there is no definition
> of valid_section_nr(),  referenced in sparse_init.

What's your .config?  I didn't actually try it on ppc64, and I may have
missed one of the necessary patches.  I trimmed it down to very near the
minimum set on x86.

-- Dave

