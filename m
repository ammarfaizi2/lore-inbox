Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWBCPFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWBCPFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWBCPF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:05:29 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:5637 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750723AbWBCPF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:05:29 -0500
In-Reply-To: <20060203094042.GB30738@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4E664E06-C8C5-4345-BAF5-566D694625C1@kernel.crashing.org>
Cc: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8250 serial console fixes -- issue
Date: Fri, 3 Feb 2006 09:05:31 -0600
To: Russell King <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

Any theories on the initial issue that Alan's patch introduces for me  
on my embedded PPC.  At this point I have to revert the whole patch  
to make this work "correctly".

thanks

- k
