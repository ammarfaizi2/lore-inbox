Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbRFGKGH>; Thu, 7 Jun 2001 06:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbRFGKF5>; Thu, 7 Jun 2001 06:05:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262400AbRFGKFm>;
	Thu, 7 Jun 2001 06:05:42 -0400
Date: Thu, 7 Jun 2001 11:05:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Message-ID: <20010607110507.A1765@flint.arm.linux.org.uk>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com> <3B1E5CC1.553B4EF1@alacritech.com> <15134.42714.3365.32233@theor.em.cig.mot.com> <15134.43914.98253.998655@pizda.ninka.net> <3B1EC74D.6C720537@candelatech.com> <15134.49211.159673.522020@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15134.49211.159673.522020@pizda.ninka.net>; from davem@redhat.com on Wed, Jun 06, 2001 at 04:43:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 04:43:55PM -0700, David S. Miller wrote:
> And my current understanding is that allowing proprietary
> reimplementations of the VM, VFS, and core networking, is not one of
> the things which is allowed.

Umm, any commercial company can come along and re-implement any part of
the Linux kernel, produce a distribution or supply kernel binary images
as long as they make available the source code to the people they
supply the kernel binary to, and no more.

People do this already with the kernel.  You're not really preventing
this, and neither does the GPL prevent it.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

