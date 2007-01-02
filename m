Return-Path: <linux-kernel-owner+w=401wt.eu-S932872AbXABLo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872AbXABLo7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbXABLo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:44:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:49287 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872AbXABLo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:44:59 -0500
In-Reply-To: <1167709531.6165.9.camel@localhost.localdomain>
References: <459714A6.4000406@firmworks.com> <20061230.211941.74748799.davem@davemloft.net> <1167709531.6165.9.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9e8f8dbd7409cedd67c3b143e6d827b1@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, wmb@firmworks.com, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 12:45:23 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In addition, I haven't given on the idea one day of actually merging 
> the
> powerpc and sparc implementation of a lot of that stuff. Mostly the
> device-tree accessors proper, the of_device/of_platform bits etc... 
> into
> something like drivers/of1394 maybe.

1394?  :-)

> Thus if i386 is going to have a device-tree, please use the same
> interfaces.

Such a hypothetical "converged" interface would not be
identical to either the current SPARC or the PowerPC
code, nor just a mix of those two.  It's a great plan
to try to get to this eventually, but it will take time.
A lot of it perhaps.


Segher

