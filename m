Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbTEOTnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTEOTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:43:14 -0400
Received: from holomorphy.com ([66.224.33.161]:1489 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264206AbTEOTnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:43:12 -0400
Date: Thu, 15 May 2003 12:55:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       keith maanthey <kmannth@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <20030515195519.GT8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	keith maanthey <kmannth@us.ibm.com>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com> <20030515065120.GA3469@Wotan.suse.de> <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com> <20030515172855.GA10831@Wotan.suse.de> <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com> <20030515190006.GA30173@Wotan.suse.de> <20030515191919.GR8978@holomorphy.com> <20030515195013.GA8724@Wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515195013.GA8724@Wotan.suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Okay, will fix.

On Thu, May 15, 2003 at 09:50:13PM +0200, Andi Kleen wrote:
> What do you want to fix? Really - an subarchitecture costs 1-2 K, 
> it's not worth any effort to make it more finegrained.

Finegrained I didn't care about. I meant the subarch hooks.


-- wli
