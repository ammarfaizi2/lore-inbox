Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWEPO7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWEPO7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWEPO7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:59:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14720 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751191AbWEPO7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:59:30 -0400
Message-ID: <4469E8CF.9030506@garzik.org>
Date: Tue, 16 May 2006 10:59:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: schierlm@gmx.de
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <e4coc8$onk$1@sea.gmane.org>
In-Reply-To: <e4coc8$onk$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Schierl wrote:

> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
> 
>> ahci:		new EH, irq-pio, NCQ, hotplug
> 
> Should suspend-to-RAM work now on AHCI?

It probably still needs Hannes' AHCI patch, and possibly the SATA ACPI 
patches too.

	Jeff


