Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTICToh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTICTnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:43:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54032
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264406AbTICTlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:41:19 -0400
Date: Wed, 3 Sep 2003 12:41:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030903194133.GC16361@matchmail.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E19uQsT-0007mk-00@calista.inka.de> <1062590946.19059.18.camel@dhcp23.swansea.linux.org.uk> <25950000.1062601832@[10.10.2.4]> <20030903160133.GA23538@wohnheim.fh-wedel.de> <31570000.1062606101@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31570000.1062606101@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 09:21:47AM -0700, Martin J. Bligh wrote:
> I've seen people use big machines for clusterable things, which I think
> is a waste of money, but the cost of the machine compared to the cost
> of admin (vs multiple machines) may have come down to the point where 
> it's worth it now. You get implicit "cluster" load balancing done in a
> transparent way by the OS on NUMA boxes.

Doesn't SSI clustering do something similar (without the effency of the
interconnections though)?
