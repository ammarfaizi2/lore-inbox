Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWJEUgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWJEUgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWJEUgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:36:22 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:62423 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751277AbWJEUgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:36:22 -0400
Date: Thu, 5 Oct 2006 22:36:20 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Misha Tomushev <misha@fabric7.com>
Cc: Jeff Garzik <jeff@garzik.org>, KERNEL Linux <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/10] VIOC: New Network Device Driver
Message-ID: <20061005203620.GA22285@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Misha Tomushev <misha@fabric7.com>, Jeff Garzik <jeff@garzik.org>,
	KERNEL Linux <linux-kernel@vger.kernel.org>
References: <200610051059.36647.misha@fabric7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610051059.36647.misha@fabric7.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 10:59:36AM -0700, Misha Tomushev wrote:

> +/* communications COMMAND REGISTERS */
> +#define SPP_SIM_PMM_CMDREG     GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
> VREG_BMC_REG_R1)
> +#define VIOCCP_SPP_SIM_PMM_CMDREG              \
> +                       VIOCCP_GETRELADDR(SPP_MODULE, SPP_CMD_REG_BANK, 
> VREG_BMC_REG_R1)

Your mailer wrapped the messages, making your patches hard to apply. 

Good luck getting this driver merged! Interesting concept.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
