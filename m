Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTEOTqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbTEOTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:46:50 -0400
Received: from franka.aracnet.com ([216.99.193.44]:12763 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264192AbTEOTqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:46:48 -0400
Date: Thu, 15 May 2003 10:45:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, keith maanthey <kmannth@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <248870000.1053020700@[10.10.2.4]>
In-Reply-To: <20030515195519.GT8978@holomorphy.com>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com> <20030515065120.GA3469@Wotan.suse.de> <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com> <20030515172855.GA10831@Wotan.suse.de> <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com> <20030515190006.GA30173@Wotan.suse.de> <20030515191919.GR8978@holomorphy.com> <20030515195013.GA8724@Wotan.suse.de> <20030515195519.GT8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Okay, will fix.
> 
> On Thu, May 15, 2003 at 09:50:13PM +0200, Andi Kleen wrote:
>> What do you want to fix? Really - an subarchitecture costs 1-2 K, 
>> it's not worth any effort to make it more finegrained.
> 
> Finegrained I didn't care about. I meant the subarch hooks.

For what? They work already AFAICS, apart from the issue that John
is already dealing with.

M.

