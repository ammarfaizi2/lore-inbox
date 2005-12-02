Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVLBANS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVLBANS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVLBANS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:13:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:36570 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932577AbVLBANQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:13:16 -0500
Subject: Re: Better pagecache statistics ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0512011310030.25135@schroedinger.engr.sgi.com>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet> <20051201160044.GB14499@dmt.cnet>
	 <Pine.LNX.4.62.0512011310030.25135@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 16:13:20 -0800
Message-Id: <1133482400.21429.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 13:16 -0800, Christoph Lameter wrote:
> We are actually looking at have better pagecache statistics and I have 
> been trying out a series of approaches. The direct need right now is to 
> have some statistics on the size of the pagecache and the number of 
> unmapped file backed pages per node.
> 

Cool. I would be interested in it. Where are you collecting the
statistics ?

Thanks,
Badari

