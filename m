Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVESOyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVESOyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVESOyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:54:09 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:13988 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262534AbVESOyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:54:05 -0400
Subject: Re: [patch 2/4] add x86-64 Kconfig options for sparsemem
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20050518165358.GF88141@muc.de>
References: <200505181643.j4IGhm7S026977@snoqualmie.dp.intel.com>
	 <20050518165358.GF88141@muc.de>
Content-Type: text/plain
Date: Thu, 19 May 2005 07:53:44 -0700
Message-Id: <1116514424.26955.119.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 18:53 +0200, Andi Kleen wrote:
> Hmm, I would have assumed IBM tested it, since Dave Hansen signed off - 
> they have a range of Opteron machines.   If not I can test it
> on a few boxes later.

I actually don't personally have any access to Opteron machines.  But, I
know Keith Mannthey has been testing it all along on his various x86_64
machines.  I'll certainly make sure we get another run on all of those
once it goes into -mm.

-- Dave

