Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWB0PxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWB0PxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWB0PxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:53:03 -0500
Received: from fmr17.intel.com ([134.134.136.16]:42380 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751250AbWB0PxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:53:02 -0500
Message-ID: <44032046.9050806@linux.intel.com>
Date: Mon, 27 Feb 2006 16:52:38 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 3/4] Move the base kernel to 2Mb to align with TLB boundaries
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <1141054297.2992.140.camel@laptopd505.fenrus.org> <200602271636.56096.ak@suse.de>
In-Reply-To: <200602271636.56096.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 27 February 2006 16:31, Arjan van de Ven wrote:
>> As suggested by Andi (and Alan), move the default kernel location
>> from 1Mb to 2Mb, to align to the start of a TLB entry.
> 
> I already have that and the head.S patch in my tree.
> 

ok they haven't changed so no need to update your tree. I've included 
them to get the full series for people who don't use your tree ;-)
