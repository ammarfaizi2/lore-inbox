Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277022AbRJHRju>; Mon, 8 Oct 2001 13:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277024AbRJHRjk>; Mon, 8 Oct 2001 13:39:40 -0400
Received: from robur.slu.se ([130.238.98.12]:24077 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S277022AbRJHRj3>;
	Mon, 8 Oct 2001 13:39:29 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15297.58736.505995.577308@robur.slu.se>
Date: Mon, 8 Oct 2001 19:42:08 +0200
To: jamal <hadi@cyberus.ca>
Cc: <kuznet@ms2.inr.ac.ru>, Andreas Dilger <adilger@turbolabs.com>,
        <Robert.Olsson@data.slu.se>, <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>, <bcrl@redhat.com>,
        <netdev@oss.sgi.com>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110080948330.5473-100000@shell.cyberus.ca>
In-Reply-To: <200110051917.XAA23007@ms2.inr.ac.ru>
	<Pine.GSO.4.30.0110080948330.5473-100000@shell.cyberus.ca>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jamal writes:
 > 
 > This was Robert actually; conclusion was Interupts are very expensive. If
 > we can get rid of as many of them as possible, we are getting a side
 > benefit. I cant find the old data, but Robert has some data over here:
 > http://robur.slu.se/Linux/net-development/experiments/010301


 Jamal! 

 I think you ment:
 http://robur.slu.se/Linux/net-development/experiments/010313

 MB with PIC irq controller IO-APIC boards does a lot better.

 Cheers.

						--ro
