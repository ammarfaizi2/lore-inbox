Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUCEV3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUCEV3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:29:24 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:26060 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262117AbUCEV3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:29:23 -0500
Date: Fri, 05 Mar 2004 13:28:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>
cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <63620000.1078522134@flay>
In-Reply-To: <20040305152622.GA14375@elte.hu>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <20040305152622.GA14375@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
>> It's a nogo for 64G but I would be really pleased to see a workload
>> triggering the zone-normal shortage in 32G, I've never seen any one. 
>> [...]
> 
> have you tried TPC-C/TPC-H?

We're doing those here. Publishing results will be tricky due to their
draconian rules, but I'm sure you'll be able to read between the lines ;-)

OASB (Oracle apps) is the other total killer I've found in the past.

M.

