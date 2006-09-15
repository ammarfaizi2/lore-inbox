Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWIOR7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWIOR7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIOR7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:59:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27352 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751287AbWIOR7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:59:16 -0400
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on
	recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robin Lee Powell <rlpowell@digitalkingdom.org>
Cc: Bharath Ramesh <krosswindz@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060915174701.GN4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org>
	 <20060914190548.GI4610@chain.digitalkingdom.org>
	 <1158261249.7948.111.camel@mindpipe>
	 <20060914191555.GJ4610@chain.digitalkingdom.org>
	 <c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com>
	 <20060915174701.GN4610@chain.digitalkingdom.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 19:22:53 +0100
Message-Id: <1158344573.29932.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 10:47 -0700, ysgrifennodd Robin Lee Powell:
> I didn't know about mce=bootlog.  Neat.  It doesn't change anything,
> though.  I've tried noacpi and many variants thereon; no change.
> 
> The most severe set of options I have record of trying is:
> 
> nosmp noapic mem=512M ide=nodma apm=off acpi=off desktop showopts

What did the various pci= options I suggested do - anything ?

