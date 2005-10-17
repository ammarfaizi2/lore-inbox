Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVJQSqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVJQSqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVJQSqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:46:01 -0400
Received: from mx3.actcom.co.il ([192.114.47.65]:20630 "EHLO
	smtp3.actcom.co.il") by vger.kernel.org with ESMTP id S932250AbVJQSqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:46:00 -0400
Date: Mon, 17 Oct 2005 20:45:23 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com, muli@il.ibm.com, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017184523.GB26239@granada.merseine.nu>
References: <20051017093654.GA7652@localhost.localdomain> <200510172008.24669.ak@suse.de> <20051017182755.GA26239@granada.merseine.nu> <200510172032.45972.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510172032.45972.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 08:32:45PM +0200, Andi Kleen wrote:

> > and would like to be able to run 2.6.14 on them when it 
> > comes out...
> 
> So you're saying you tested it and it doesn't work? 

Not quite; I'm saying that form the description up-thread it sounds
like there's a good chance it won't. Jon Mason (CC'd) has access to
such a  machine. Jon, can you please try the latest hg tree with and
without the patch and see how it fares?

Thanks,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

