Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSKVBxf>; Thu, 21 Nov 2002 20:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSKVBxf>; Thu, 21 Nov 2002 20:53:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20931 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264785AbSKVBxf>; Thu, 21 Nov 2002 20:53:35 -0500
Subject: Re: [RFC] [PATCH] subarch-cleanup_A1
From: john stultz <johnstul@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021122014817.GU23425@holomorphy.com>
References: <1037929596.7576.78.camel@w-jstultz2.beaverton.ibm.com>
	 <20021122014817.GU23425@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037930409.7576.90.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Nov 2002 18:00:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 17:48, William Lee Irwin III wrote:
> On Thu, Nov 21, 2002 at 05:46:36PM -0800, john stultz wrote:
> > Ok, next pass. How about this: (complete patch bz'ed and attached)
> 
> Would you like me to send you a patch to do strong typing
> (== wrap in structs) on the various flavors of APIC ID's?
> 
> I'll do so overnight when west coast .us is most likely to sleep if so.

a bit out of context from this patch, but yea, I'd be interested in
seeing it. although, unless your just itching to do it, how about
waiting until after the numaq subarch stuff is cleaned up a bit more? 

thanks
-john


