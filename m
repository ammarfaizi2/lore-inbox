Return-Path: <linux-kernel-owner+w=401wt.eu-S964777AbXASSE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbXASSE6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbXASSE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:04:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58480 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932831AbXASSE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:04:57 -0500
Date: Fri, 19 Jan 2007 10:02:40 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, pj@sgi.com
Subject: Re: [PATCH] nfs: fix congestion control
In-Reply-To: <1169229461.6197.154.camel@twins>
Message-ID: <Pine.LNX.4.64.0701191001340.14617@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
  <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy> 
 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com> 
 <1169070763.5975.70.camel@lappy>  <1169070886.6523.8.camel@lade.trondhjem.org>
  <1169126868.6197.55.camel@twins>  <1169135375.6105.15.camel@lade.trondhjem.org>
  <1169199234.6197.129.camel@twins> <1169212022.6197.148.camel@twins> 
 <Pine.LNX.4.64.0701190912540.14617@schroedinger.engr.sgi.com>
 <1169229461.6197.154.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Peter Zijlstra wrote:

> Eeuh, right. Glad to have you around to remind how puny my boxens
> are :-)

Sorry about that but it was unavoidable if we want to get to reasonable 
limits that will work in all situations.

