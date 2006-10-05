Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWJEOxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWJEOxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWJEOxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:53:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:43440 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751473AbWJEOxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:53:44 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64
From: Steve Fox <drfickle@us.ibm.com>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Andi Kleen <ak@suse.de>, vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45245B03.2070803@mbligh.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20061004170659.f3b089a8.akpm@osdl.org> <20061005005124.GA23408@in.ibm.com>
	 <200610050257.53971.ak@suse.de>  <45245B03.2070803@mbligh.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 09:53:40 -0500
Message-Id: <1160060020.29690.5.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 18:08 -0700, Martin Bligh wrote:
> Andi Kleen wrote:
> >>I think most likely it would crash on 2.6.18. Keith mannthey had reported
> >>a different crash on 2.6.18-rc4-mm2 when this patch was introduced first
> >>time. Following is the link to the thread.
> > 
> > 
> > Then maybe trying 2.6.17 + the patch and then bisect between that and -rc4?
> 
> I think it's fixed already in -git22, or at least it is for the IBM box
> reporting to test.kernel.org. You might want to try that one ...

-git22 also panics for me.

-- 

Steve Fox
IBM Linux Technology Center
