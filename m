Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132612AbRDGI3Q>; Sat, 7 Apr 2001 04:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbRDGI3G>; Sat, 7 Apr 2001 04:29:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27921 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132612AbRDGI2z>;
	Sat, 7 Apr 2001 04:28:55 -0400
Date: Sat, 7 Apr 2001 09:28:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Philip Blundell <philb@gnu.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: syslog insmod please!
Message-ID: <20010407092819.A10639@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.30.0104051751410.20174-100000@andrew.triumf.ca> <693.986558015@redhat.com> <dwmw2@infradead.org> <E14lVh8-0005op-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14lVh8-0005op-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Fri, Apr 06, 2001 at 01:50:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 01:50:29PM +0100, Philip Blundell wrote:
> Floating point on ARM is indeed something of a crock, but that particular case
> used to work -- can you tell where it's going wrong?  See entry-armv.S, 
> about line 680, for the very bad hack that was supposed to facilitate this 
> kind of thing.

I've already discussed this issue with David on irc, and I resolved it a
few kernel versions ago (read my 2.4 release notes on the web site).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

