Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVH3TV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVH3TV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVH3TV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:21:26 -0400
Received: from hera.kernel.org ([209.128.68.125]:14533 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932392AbVH3TVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:21:25 -0400
Date: Tue, 30 Aug 2005 16:16:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Telecom Clock driver for MPCBL0010 ATCA compute blade.
Message-ID: <20050830191611.GA8328@dmt.cnet>
References: <200508301159.34053.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508301159.34053.mgross@linux.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark,

Please fix identation accordingly to CodingStyle and repost, it 
looks quite ugly at the moment.

On Tue, Aug 30, 2005 at 11:59:33AM -0700, Mark Gross wrote:
> The following is a driver I would like to see included in the base kernel.
> 
> It allows OS controll of a device that synchronizes signaling hardware across a ATCA chassis.
> 
> The telecom clock hardware doesn't interact much with the operating system, and is controlled 
> via registers in the FPGA on the hardware.  It is hardware that is unique to this computer.
> 
> Thanks for looking at this,
