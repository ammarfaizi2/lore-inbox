Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265469AbTFMS1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265475AbTFMS1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:27:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2743 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265469AbTFMS1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:27:11 -0400
Date: Fri, 13 Jun 2003 11:40:37 -0700
From: Greg KH <greg@kroah.com>
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Bugs sitting in the RESOLVED state for more than 28 days
Message-ID: <20030613184037.GB6492@kroah.com>
References: <3EEA1716.9000903@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEA1716.9000903@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 02:25:26PM -0400, Stacy Woods wrote:
> 412  Drivers    USB        dbrownell@users.sourceforge.net
> [EHCI] report of first interrupt transfer is delayed
> 
> 418  Drivers    USB        greg@kroah.com
> Bad use of GFP_DMA

I just closed both of these.

thanks,

greg k-h
