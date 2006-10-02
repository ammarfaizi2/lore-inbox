Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965409AbWJBVdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965409AbWJBVdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965410AbWJBVdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:33:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39113 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965409AbWJBVdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:33:43 -0400
Subject: Re: Spam, bogofilter, etc
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
References: <1159539793.7086.91.camel@mindpipe>
	 <20061002100302.GS16047@mea-ext.zmailer.org>
	 <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org>
	 <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org>
	 <1159811392.8907.36.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 22:58:32 +0100
Message-Id: <1159826312.8907.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, the MX checking can also be avoided, and a lot of spam-bots 
> know to use the ISP connection instead of a direct port-25 approach. But 
> at least that way, the mail gateway can (and often does) notice the 
> flooding, and many ISP's successfully throttle at least some spam at the 
> source, so it does actually have real meaning.

Actually some of the smarter big ISPs with the less technical customers
transproxy port 25 anyway - using big Linux boxes and the netfilter
code.

