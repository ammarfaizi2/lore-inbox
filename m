Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVIHPxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVIHPxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVIHPxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:53:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11788 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932579AbVIHPxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:53:00 -0400
Date: Thu, 8 Sep 2005 16:52:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Miller <davem@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Serial maintainership
Message-ID: <20050908165256.D5661@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Dave Miller <davem@redhat.com>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice DaveM's taken over serial maintainership.  Please arrange for
serial patches to be sent to davem in future, thanks.  (All ARM serial
drivers are broken as of Tuesday.)

I might take a different view if I at least had a curtious CC: of the
patch, which I had already asked akpm to reject.

Thanks.  That's another subsystem I don't have to care about anymore.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
