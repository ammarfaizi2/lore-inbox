Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271686AbTHDJ0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271688AbTHDJ0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:26:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3849 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271686AbTHDJ0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:26:23 -0400
Date: Mon, 4 Aug 2003 10:26:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pat Rondon <pat@thepatsite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Yenta init freezes Pavilion
Message-ID: <20030804102619.A495@flint.arm.linux.org.uk>
Mail-Followup-To: Pat Rondon <pat@thepatsite.com>,
	linux-kernel@vger.kernel.org
References: <1059962307.3774.18.camel@okcomputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1059962307.3774.18.camel@okcomputer>; from pat@thepatsite.com on Sun, Aug 03, 2003 at 09:58:27PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 09:58:27PM -0400, Pat Rondon wrote:
>   When booting my HP Pavilion zt1145 (see below), the system freezes
> once it gets to checking the cardbus status:
> 
> Yenta IRQ list 0000, PCI irq11
> Socket status: 30000006

Which kernel exhibited this behaviour, and which was the last kernel
which didn't?

Also, there should be other messages about pcmcia around that area -
it would be helpful to include those in your report.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

