Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUAYAPR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUAYAPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:15:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45290 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263571AbUAYAPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:15:13 -0500
Message-ID: <40130A81.6090400@pobox.com>
Date: Sat, 24 Jan 2004 19:14:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Santiago Leon <santil@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM PowerPC Virtual Ethernet Driver
References: <400C3CEA.1060004@us.ibm.com> <20040119205629.A5831@infradead.org>
In-Reply-To: <20040119205629.A5831@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Jan 19, 2004 at 03:24:10PM -0500, Santiago Leon wrote:
>>Jeff, can you formally add this driver to 2.4?... I'm waiting for some
>>ppc64 architectural addition to send out the driver for 2.6...
> 
> 
> I think we shouldn't accept new drivers in 2.4 anymore unless they're
> already in 2.6


The architectural dependency is queued for 2.6 and in 2.4, so I'm OK 
with it.

	Jeff



