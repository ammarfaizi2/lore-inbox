Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTICUYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTICUWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:22:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:52116 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264449AbTICUWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:22:30 -0400
Date: Wed, 03 Sep 2003 13:11:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: "J?rn Engel" <joern@wohnheim.fh-wedel.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <98770000.1062619883@flay>
In-Reply-To: <20030903194133.GC16361@matchmail.com>
References: <E19uQsT-0007mk-00@calista.inka.de> <1062590946.19059.18.camel@dhcp23.swansea.linux.org.uk> <25950000.1062601832@[10.10.2.4]> <20030903160133.GA23538@wohnheim.fh-wedel.de> <31570000.1062606101@[10.10.2.4]> <20030903194133.GC16361@matchmail.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 03, 2003 at 09:21:47AM -0700, Martin J. Bligh wrote:
>> I've seen people use big machines for clusterable things, which I think
>> is a waste of money, but the cost of the machine compared to the cost
>> of admin (vs multiple machines) may have come down to the point where 
>> it's worth it now. You get implicit "cluster" load balancing done in a
>> transparent way by the OS on NUMA boxes.
> 
> Doesn't SSI clustering do something similar (without the effency of the
> interconnections though)?

Yes ... *if* someone had a implementation that worked well and was 
maintainable ;-)

M.

