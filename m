Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUBEKAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUBEKAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:00:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11536 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263760AbUBEKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:00:09 -0500
Date: Thu, 5 Feb 2004 10:00:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <20040205100004.A5426@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040205014405.5a2cf529.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040205014405.5a2cf529.akpm@osdl.org>; from akpm@osdl.org on Thu, Feb 05, 2004 at 01:44:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 01:44:05AM -0800, Andrew Morton wrote:
>  bk-netdev.patch

Does this include the changes to all those PCMCIA net drivers which
Jeff has had for a while from me?

I'd like to get those patches into mainline so I can close bugme bug
1711, but I think Jeff's waiting for responses from the individual
net driver maintainers first. ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
