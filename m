Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277330AbRJEHzU>; Fri, 5 Oct 2001 03:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277329AbRJEHzI>; Fri, 5 Oct 2001 03:55:08 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:30169 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S277327AbRJEHy6>; Fri, 5 Oct 2001 03:54:58 -0400
Date: Fri, 5 Oct 2001 08:55:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ian Thompson <ithompso@stargateip.com>
Cc: root@chaos.analogic.com, Helge Hafting <helgehaf@idb.hist.no>,
        linux-kernel@vger.kernel.org
Subject: Re: How can I jump to non-linux address space?
Message-ID: <20011005085526.A17541@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.3.95.1011004155938.1774A-100000@chaos.analogic.com> <NFBBIBIEHMPDJNKCIKOBGEIOCAAA.ithompso@stargateip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBGEIOCAAA.ithompso@stargateip.com>; from ithompso@stargateip.com on Thu, Oct 04, 2001 at 05:35:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 05:35:51PM -0700, Ian Thompson wrote:
> Hey Dick,
> Should I be looking for something else to twiddle instead of the MMU bit in
> the CPU register?  You mentioned the paging bit; is this different?  Also,
> what are DS & ES?

Dick is talking about x86 hardware, not your ARM hardware.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

