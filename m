Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263754AbVBEJEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbVBEJEf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbVBEJEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:04:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3849 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263754AbVBEI6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 03:58:35 -0500
Date: Sat, 5 Feb 2005 08:58:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [-mm PATCH] driver model: PM type conversions in drivers/net
Message-ID: <20050205085828.A30866@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-pm@osdl.org
References: <4203F3D5.9060605@gentoo.org> <42041ADD.8050606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42041ADD.8050606@pobox.com>; from jgarzik@pobox.com on Fri, Feb 04, 2005 at 08:01:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 08:01:17PM -0500, Jeff Garzik wrote:
> Why does this one have three arguments?

Because it's a platform device driver suspend method.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
