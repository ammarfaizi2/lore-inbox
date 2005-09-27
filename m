Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbVI0XgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVI0XgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVI0XgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:36:05 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:16527 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965209AbVI0XgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:36:03 -0400
Date: Tue, 27 Sep 2005 16:35:54 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alokk@calsoftinc.com
Subject: Re: 2.6.14-rc2 early boot OOPS (mm/slab.c:1767)
In-Reply-To: <20050927202858.GG1046@vega.lnet.lut.fi>
Message-ID: <Pine.LNX.4.62.0509271630050.11040@schroedinger.engr.sgi.com>
References: <20050927202858.GG1046@vega.lnet.lut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005, Tomi Lapinlampi wrote:

> I'm getting the following OOPS with 2.6.14-rc2 on an Alpha.

Hmmm. I am not familiar with Alpha. The .config looks as if this is a 
uniprocessor configuration? No NUMA? 

What is the value of MAX_NUMNODES?

