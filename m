Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbUCPEVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 23:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUCPEVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 23:21:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262803AbUCPEVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 23:21:14 -0500
Message-ID: <405680AB.4020709@pobox.com>
Date: Mon, 15 Mar 2004 23:20:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does "ALI M15x3 chipset support" in drivers/ide support SATA
 PCI cards?
References: <40567B80.5090009@matchmail.com>
In-Reply-To: <40567B80.5090009@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Hi,
> 
> I'm looking at non-SIL3112 based SATA PCI cards, and came across some 
> ALI M1583 based SATA controllers.
> 
> Should I have a smooth ride with these cards in Linux?


I haven't seen support for ALi SATA in the IDE driver nor libata...

	Jeff



