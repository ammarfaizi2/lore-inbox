Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTEOThY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTEOThY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:37:24 -0400
Received: from ns.suse.de ([213.95.15.193]:38666 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264190AbTEOThX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:37:23 -0400
Date: Thu, 15 May 2003 21:50:13 +0200
From: Andi Kleen <ak@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       keith maanthey <kmannth@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <20030515195013.GA8724@Wotan.suse.de>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com> <20030515065120.GA3469@Wotan.suse.de> <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com> <20030515172855.GA10831@Wotan.suse.de> <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com> <20030515190006.GA30173@Wotan.suse.de> <20030515191919.GR8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515191919.GR8978@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay, will fix.

What do you want to fix? Really - an subarchitecture costs 1-2 K, 
it's not worth any effort to make it more finegrained.

-Andi
