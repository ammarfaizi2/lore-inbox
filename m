Return-Path: <linux-kernel-owner+w=401wt.eu-S932111AbXAVR7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbXAVR7z (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 12:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbXAVR7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 12:59:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34934 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932148AbXAVR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 12:59:53 -0500
Date: Mon, 22 Jan 2007 09:59:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, pj@sgi.com
Subject: Re: [PATCH] nfs: fix congestion control -v3
In-Reply-To: <1169276500.6197.159.camel@twins>
Message-ID: <Pine.LNX.4.64.0701220956590.24578@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
  <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy> 
 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com> 
 <1169070763.5975.70.camel@lappy>  <1169070886.6523.8.camel@lade.trondhjem.org>
  <1169126868.6197.55.camel@twins>  <1169135375.6105.15.camel@lade.trondhjem.org>
  <1169199234.6197.129.camel@twins> <1169212022.6197.148.camel@twins> 
 <Pine.LNX.4.64.0701190912540.14617@schroedinger.engr.sgi.com> 
 <1169229461.6197.154.camel@twins>  <1169231212.5775.29.camel@lade.trondhjem.org>
 <1169276500.6197.159.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2007, Peter Zijlstra wrote:

> Subject: nfs: fix congestion control

I am not sure if its too valuable since I have limited experience with NFS 
but it looks fine to me.

Acked-by: Christoph Lameter <clameter@sgi.com>

