Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbUCEPZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUCEPZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:25:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58532 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262622AbUCEPZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:25:14 -0500
Date: Fri, 5 Mar 2004 16:26:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305152622.GA14375@elte.hu>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305145837.GZ4922@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> It's a nogo for 64G but I would be really pleased to see a workload
> triggering the zone-normal shortage in 32G, I've never seen any one. 
> [...]

have you tried TPC-C/TPC-H?

	Ingo
