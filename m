Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbULPOUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbULPOUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbULPOUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:20:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10956 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262679AbULPOS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:18:59 -0500
Date: Thu, 16 Dec 2004 08:18:14 -0600
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@suse.de>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org, jrsantos@austin.ibm.com
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041216141814.GA10292@rx8.austin.ibm.com>
References: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <50260000.1103061628@flay> <20041215045855.GH27225@wotan.suse.de> <20041215144730.GC24000@krispykreme.ozlabs.ibm.com> <20041216050248.GG32718@wotan.suse.de> <20041216051323.GI24000@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216051323.GI24000@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> [041215]:
>  
> > I asked Brent to run some benchmarks originally and I believe he has 
> > already run all that he could easily set up. If you want more testing
> > you'll need to test yourself I think. 
> 
> We will be testing it.

By "We" you mean "Me" right? :)

I can do the SpecSFS runs but each runs takes several hours to complete
and I would need to do two runs (baseline and patched).  I may have it 
ready by today or tommorow.

-JRS
