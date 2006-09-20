Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWITQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWITQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWITQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:26:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25042 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751748AbWITQ0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:26:55 -0400
Date: Wed, 20 Sep 2006 09:26:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: rohitseth@google.com, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <4510D3F4.1040009@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609200925280.30572@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <4510D3F4.1040009@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Nick Piggin wrote:

> I'm not sure about containers & workload management people, but from
> a core mm/ perspective I see no reason why this couldn't get in,
> given review and testing. Great!

Nack. We already have the ability to manage workloads. We may want to 
extend the existing functionality but this is duplicating what is already 
available through cpusets.
