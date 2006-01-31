Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWAaS4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWAaS4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWAaS4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:56:34 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:25756 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751345AbWAaS4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:56:33 -0500
Date: Tue, 31 Jan 2006 19:56:46 +0100
From: Sander <sander@humilis.net>
To: Joshua Kugler <joshua.kugler@uaf.edu>
Cc: linux-kernel@vger.kernel.org, sander@humilis.net, jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131185646.GF6178@favonius>
Reply-To: sander@humilis.net
References: <20060131115343.GA2580@favonius> <200601310919.20199.joshua.kugler@uaf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601310919.20199.joshua.kugler@uaf.edu>
X-Uptime: 18:06:22 up  7:50, 21 users,  load average: 0.18, 0.15, 0.09
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kugler wrote (ao):
> I've run some tests with this card under Linux and done pretty well:
> 
> http://www.supermicro.com/products/accessories/addon/DAC-SATA-MV8.cfm
> 
> They also have a 3.0Gb version.
> 
> Not sure if that is AHCI, but it is eight port.

Marvell has their own chipset, according to
http://linux.yyz.us/sata/sata-status.html#marvell

> I got the drivers here:
> 
> http://www.keffective.com/mvsata/FC3/
> 
> The latest was mvSata_Linux_3.6.1.tgz as of 2005-10-13.

I very, very much prefer in-tree drivers :-)

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
