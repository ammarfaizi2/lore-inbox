Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133018AbRDWMcW>; Mon, 23 Apr 2001 08:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133022AbRDWMcN>; Mon, 23 Apr 2001 08:32:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S133018AbRDWMcH>;
	Mon, 23 Apr 2001 08:32:07 -0400
Date: Mon, 23 Apr 2001 13:32:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: All architecture maintainers: pgd_alloc()
Message-ID: <20010423133202.A26121@flint.arm.linux.org.uk>
In-Reply-To: <20010421154455.C7576@flint.arm.linux.org.uk> <15075.45847.624767.960502@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15075.45847.624767.960502@pizda.ninka.net>; from davem@redhat.com on Sun, Apr 22, 2001 at 09:44:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 09:44:07PM -0700, David S. Miller wrote:
> I really would wish folks would not choose Alan as the first place
> to send the patch.  I'm not directly accusing anyone of it, but it
> does appear that often AC is used as a "back door" to get a change
> in.  While this scheme most of the time, often it unnecessarily
> overworks Alan which I think is unfair.

The reason I suggested sending this stuff to Alan is because it _needs_
to be reviewed or tested before coming out in Linus tree, and I know
that Linus is trying to get 2.4.4 out.

Last time I checked, ARM can't run a Sparc kernel. ;)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

