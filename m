Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVJQScX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVJQScX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVJQScX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:32:23 -0400
Received: from mail.suse.de ([195.135.220.2]:29906 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932202AbVJQScX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:32:23 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 20:32:45 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com
References: <20051017093654.GA7652@localhost.localdomain> <200510172008.24669.ak@suse.de> <20051017182755.GA26239@granada.merseine.nu>
In-Reply-To: <20051017182755.GA26239@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172032.45972.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 20:27, Muli Ben-Yehuda wrote:
> On Mon, Oct 17, 2005 at 08:08:24PM +0200, Andi Kleen wrote:
> > On Monday 17 October 2005 19:52, Ravikiran G Thirumalai wrote:
> > > No they are not.  IBM X460s are generally available machines and  the
> > > bug affects those boxes.
> >
> > No reports from that front so far.
>
> We have such machines with >4GB memory and 32 bit DMA capable SCSI
> controllers 

32bit DMA SCSI controllers??? Where did you find such a beast?

> and would like to be able to run 2.6.14 on them when it 
> comes out...

So you're saying you tested it and it doesn't work? 

-Andi
