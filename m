Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVBHUvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVBHUvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVBHUvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:51:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2532 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261660AbVBHUvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:51:09 -0500
Date: Tue, 8 Feb 2005 12:51:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: prezeroing V6 [2/3]: ScrubD
In-Reply-To: <20050208122758.5c669281.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502081249220.5796@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
 <20050207163035.7596e4dd.akpm@osdl.org> <Pine.LNX.4.58.0502071646170.29971@schroedinger.engr.sgi.com>
 <20050207170947.239f8696.akpm@osdl.org> <Pine.LNX.4.58.0502071710580.30068@schroedinger.engr.sgi.com>
 <20050207173559.68ce30e3.akpm@osdl.org> <Pine.LNX.4.58.0502080807410.3169@schroedinger.engr.sgi.com>
 <20050208122758.5c669281.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005, Andrew Morton wrote:

> We also need to try to identify workloads whcih might experience a
> regression and test them too.  It isn't very hard.

I'd be glad if you could provide some instructions on how exactly to do
that. I have run lmbench, aim9, aim7, unixbench, ubench for a couple of
configurations. But which configurations do you want?
