Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311856AbSDNJ0o>; Sun, 14 Apr 2002 05:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSDNJ0n>; Sun, 14 Apr 2002 05:26:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37133 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311856AbSDNJ0n>; Sun, 14 Apr 2002 05:26:43 -0400
Date: Sun, 14 Apr 2002 10:26:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: spyro@armlinux.org, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-ID: <20020414102632.A30379@flint.arm.linux.org.uk>
In-Reply-To: <20020414004022.6450f038.spyro@armlinux.org> <32607.1018743108@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 10:11:48AM +1000, Keith Owens wrote:
> Any particular reason for not using ksymoops?  If it does not work on
> arm, I can get rid of all the arm code ;).

It does work on ARM.  I use it, and we've had a few posts using it.
However, since it took several _months_ for the ksymoops version with
the fixed regexps for ARM to come out, I don't really think you're
justified in the above comments.

However, it's just that most people don't bother to think about reading
any documentation (like REPORTING-BUGS) and think that just posting
random bits is sufficient.  It's difficult enough to get these people to
post basic things like kernel versions and so forth.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

