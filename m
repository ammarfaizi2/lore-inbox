Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUIOXZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUIOXZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIOXV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:21:56 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:33511 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S267720AbUIOWpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:45:12 -0400
Message-ID: <4148C672.4050905@tomt.net>
Date: Thu, 16 Sep 2004 00:47:14 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [sata] new libata-dev-2.6 queue created (AHCI, SATA bridges)
References: <20040915161026.GA31360@havoc.gtf.org>
In-Reply-To: <20040915161026.GA31360@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> I have updated my SATA status page to reflect these updates:
> 	http://linux.yyz.us/sata/sata-status.html

Good stuff :-)

Is there any news on Marvell progress? I'll get my hands dirty on a 
shipment with servers using the chips on friday, I may be able to sneak 
in some testing before deployment (they will be rewired to use ICH5-R 
for now)

Hmm, I wonder if there is any AHCI PCI(-X/E) plug-in boards planned. 
That would be nice indeed. Seems like SATAII-like features on PCI-boards 
are bound to Marvell or hardware RAID cards like 3ware 9xxx or newer LSI 
MegaRAID currently.
