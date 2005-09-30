Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbVI3PQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVI3PQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVI3PQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:16:30 -0400
Received: from mx.pathscale.com ([64.160.42.68]:19665 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030332AbVI3PQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:16:29 -0400
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, vandrove@vc.cvut.cz, clameter@engr.sgi.com,
       alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org, ananth@in.ibm.com,
       ak@suse.de
In-Reply-To: <20050930062853.GB3599@localhost.localdomain>
References: <20050919112912.18daf2eb.akpm@osdl.org>
	 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
	 <20050919122847.4322df95.akpm@osdl.org>
	 <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
	 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
	 <20050928210245.GA3760@localhost.localdomain> <433C1999.2060201@vc.cvut.cz>
	 <20050930054556.GA3599@localhost.localdomain>
	 <20050929230540.6a8651fa.akpm@osdl.org>
	 <20050930062853.GB3599@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 08:16:22 -0700
Message-Id: <1128093382.10913.92.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 23:28 -0700, Ravikiran G Thirumalai wrote:

> Yes. 

Kiran, your patch works for me, too.  I can boot 2.6.14-rc2 with your
patch, but not without it.

Thanks for your help.

	<b

