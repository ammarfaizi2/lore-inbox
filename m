Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSKVBoR>; Thu, 21 Nov 2002 20:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSKVBoR>; Thu, 21 Nov 2002 20:44:17 -0500
Received: from holomorphy.com ([66.224.33.161]:64387 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264786AbSKVBoQ>;
	Thu, 21 Nov 2002 20:44:16 -0500
Date: Thu, 21 Nov 2002 17:48:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: john stultz <johnstul@us.ibm.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch-cleanup_A1
Message-ID: <20021122014817.GU23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	john stultz <johnstul@us.ibm.com>,
	"J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1037929596.7576.78.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037929596.7576.78.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 05:46:36PM -0800, john stultz wrote:
> Ok, next pass. How about this: (complete patch bz'ed and attached)

Would you like me to send you a patch to do strong typing
(== wrap in structs) on the various flavors of APIC ID's?

I'll do so overnight when west coast .us is most likely to sleep if so.


Bill
