Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbUJ1ARX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUJ1ARX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUJ1ANc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:13:32 -0400
Received: from dvhart.tempdomainname.com ([128.121.61.168]:6159 "HELO
	mindlib.com") by vger.kernel.org with SMTP id S262740AbUJ1ADY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:03:24 -0400
Subject: Re: [PATCH] active_load_balance() fixlet
To: Matt Dobson <colpatch@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1098921429.20183.27.camel@arrakis>
References: <1098921429.20183.27.camel@arrakis>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 17:03:13 -0700
Message-Id: <1098921793.17741.8.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
From: Darren Hart <darren@dvhart.com>
X-Delivery-Agent: TMDA/0.89 (Chateaugay)
X-Primary-Address: darren@dvhart.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 16:57 -0700, Matthew Dobson wrote:
> Darren, Andrew, and scheduler folks,
> 
> There is a small problem with the active_load_balance() patch that
> Darren sent out last week.

This cleans up some awkward tests in my patch as well.  Looks good to
me.

-- 
Darren Hart <darren@dvhart.com>
