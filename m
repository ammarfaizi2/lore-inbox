Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269404AbRGaSoA>; Tue, 31 Jul 2001 14:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269411AbRGaSnu>; Tue, 31 Jul 2001 14:43:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269404AbRGaSnc>;
	Tue, 31 Jul 2001 14:43:32 -0400
Date: Tue, 31 Jul 2001 19:43:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Stuart MacDonald <stuartm@connecttech.com>, Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
Message-ID: <20010731194334.A22632@flint.arm.linux.org.uk>
In-Reply-To: <000701c119cd$ebf0c720$294b82ce@connecttech.com> <200107311639.f6VGdciQ020335@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107311639.f6VGdciQ020335@webber.adilger.int>; from adilger@turbolinux.com on Tue, Jul 31, 2001 at 10:39:38AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 10:39:38AM -0600, Andreas Dilger wrote:
> It _may_ be that Keith Owens (I think) will change this in 2.5.  He has
> talked about a big reorg of the serial layer to separate out the tty
> handling from the serial I/O handling.  Maybe at that point my idea of
> having a console on a parallel port will work.  I guess that it is just
> not that easy right now.

Keith should contact me about it; I've got a lot of work in CVS to make
this transition easy, and I know Ted T'so's views on his intended direction
for this very subject (I discussed it with Ted at the 2.5 conference and
on odd occasions after).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

