Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262308AbREZAwE>; Fri, 25 May 2001 20:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262347AbREZAvz>; Fri, 25 May 2001 20:51:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2862 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262308AbREZAvl>; Fri, 25 May 2001 20:51:41 -0400
Date: Sat, 26 May 2001 02:51:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jay Thorne <Yohimbe@userfriendly.org>
Cc: George France <france@handhelds.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Alpha SMP Low Outbound Bandwidth
Message-ID: <20010526025119.L9634@athlon.random>
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org> <01052518523300.28075@shadowfax.middleearth> <990831934.27357.4.camel@gracie.userfriendly.org> <01052519312101.28075@shadowfax.middleearth> <990836703.27355.6.camel@gracie.userfriendly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990836703.27355.6.camel@gracie.userfriendly.org>; from Yohimbe@userfriendly.org on Fri, May 25, 2001 at 05:25:03PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 05:25:03PM -0700, Jay Thorne wrote:
> But Wu-ftpd is an easy to set up test bench, and is ubiquitous enough
> that anyone with an alpha running SMP can test it. Note that this

My smp alpha box drives a single tulip over 12MB/sec in full duplex
using tcp without any problem at all. So I definitely cannot reproduce.
You may want to try to reproduce with 2.4.5pre6aa1 btw. If you've not
tried it yet you can consider also using egcs 1.1.2 as compiler just in
case.

You may also want to keep an eye on the VM, on alpha I see very weird
things happening.

Andrea
