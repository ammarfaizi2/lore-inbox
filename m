Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWITRIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWITRIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWITRIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:08:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41432 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751979AbWITRIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:08:10 -0400
Date: Wed, 20 Sep 2006 10:08:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: rohitseth@google.com, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <451172AB.2070103@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609201006420.30793@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <4510D3F4.1040009@yahoo.com.au> <Pine.LNX.4.64.0609200925280.30572@schroedinger.engr.sgi.com>
 <451172AB.2070103@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Nick Piggin wrote:

> If it wasn't clear was talking specifically about the hooks for page
> tracking rather than the whole patchset. If anybody wants such page
> tracking infrastructure in the kernel, then this (as opposed to the
> huge beancounters stuff) is what it should look like.

Could you point to the patch and a description for what is meant here by 
page tracking (did not see that in the patch, maybe I could not find it)? 
If these are just statistics then we likely already have 
them.
