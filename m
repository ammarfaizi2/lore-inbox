Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVCQX0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVCQX0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVCQX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:26:17 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56457 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261364AbVCQX0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:26:14 -0500
Date: Thu, 17 Mar 2005 15:26:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <20050317151151.47fd6e5f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503171525360.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050317140831.414b73bb.akpm@osdl.org> <Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
 <20050317151151.47fd6e5f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Andrew Morton wrote:

> > > It's hard to know what to think about this without benchmarking numbers.

http://oss.sgi.com/projects/page_fault_performance/

