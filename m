Return-Path: <linux-kernel-owner+w=401wt.eu-S1754861AbXABUHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbXABUHW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754851AbXABUHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:07:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:42082 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861AbXABUHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:07:21 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, wmb@firmworks.com, jg@laptop.org
In-Reply-To: <9e8f8dbd7409cedd67c3b143e6d827b1@kernel.crashing.org>
References: <459714A6.4000406@firmworks.com>
	 <20061230.211941.74748799.davem@davemloft.net>
	 <1167709531.6165.9.camel@localhost.localdomain>
	 <9e8f8dbd7409cedd67c3b143e6d827b1@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 07:07:07 +1100
Message-Id: <1167768427.6165.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 12:45 +0100, Segher Boessenkool wrote:
> > In addition, I haven't given on the idea one day of actually merging 
> > the
> > powerpc and sparc implementation of a lot of that stuff. Mostly the
> > device-tree accessors proper, the of_device/of_platform bits etc... 
> > into
> > something like drivers/of1394 maybe.
> 
> 1394?  :-)

Yeah, I'm tired, of1275 :-)

> > Thus if i386 is going to have a device-tree, please use the same
> > interfaces.
> 
> Such a hypothetical "converged" interface would not be
> identical to either the current SPARC or the PowerPC
> code, nor just a mix of those two.  It's a great plan
> to try to get to this eventually, but it will take time.
> A lot of it perhaps.

Ben.


