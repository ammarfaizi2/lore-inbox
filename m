Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbULFLBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbULFLBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULFLBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:01:54 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:26261 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261496AbULFLBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:01:23 -0500
Subject: Post Network dev questions to netdev Please WAS(Re: [patch 4/10]
	s390: network driver.
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Paul Jakma <paul@clubi.ie>
Cc: Thomas Spatzier <thomas.spatzier@de.ibm.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.61.0412050605550.21671@hibernia.jakma.org>
References: <OFAF17275D.316533A1-ONC1256F5C.0026AFAD-C1256F5C.002877C1@de.ibm.com>
	 <Pine.LNX.4.61.0412050605550.21671@hibernia.jakma.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102330877.1042.2187.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Dec 2004 06:01:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 01:25, Paul Jakma wrote:

> 
> This has always been (AFAIK) the behaviour yes. We started getting 
> reports of the new queuing behaviour with, iirc, a version of Intel's 
> e100 driver for 2.4.2x, which was later changed back to the old 
> behaviour. However now that the queue behaviour is apparently the 
> mandated behaviour we really need to work out what to do about the 
> sending-long-stale packets problem.
> 

I missed the beginings of this thread. Seems some patch was posted
on lkml which started this discussion. I am pretty sure what the lkml
FAQ says is to post on netdev. Ok, If you insist posting on lkml
(because that the way to glory, good fortune and fame), then please have
the courtesy to post to netdev.  

Now lets see if we can help. Followups only on netdev.

cheers,
jamal



