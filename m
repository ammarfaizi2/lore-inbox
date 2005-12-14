Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVLNXbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVLNXbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVLNXbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:31:17 -0500
Received: from L8R.net ([216.58.41.32]:21985 "EHLO l8r.net")
	by vger.kernel.org with ESMTP id S965080AbVLNXbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:31:15 -0500
Date: Wed, 14 Dec 2005 18:31:13 -0500
From: Brad Barnett <bahb@l8r.net>
To: Erik Meitner <e.spambo1.meitner@willystreet.coop>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Megaraid abort errors
Message-ID: <20051214183113.309ac575@be.back.l8r.net>
In-Reply-To: <dnq3qj$hu5$1@sea.gmane.org>
References: <dnq3qj$hu5$1@sea.gmane.org>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005 15:45:55 -0600
Erik Meitner <e.spambo1.meitner@willystreet.coop> wrote:

> I have a server(SuperMicro SuperServer SS5033C-T) with an
> LSI Logic MegaRAID SATA 150-6 card with three ~300Gb disks in a RAID-5
> array.
> 
> About every 1 to 2 weeks the SCSI driver for the Megaraid card will
> cease operating and the system will then require a hard reboot. Logs and
> details below. Please let me know if there is any other information that
> may help in troubleshooting this.

I am not able to tell if the firmware of the card is listed below. 
However, the first thing I would look at is what updates have occurred in
firmwares, and compare that with what you have.

You should likely do the same with the motherboard.

I have three of those cards in two Supermicro P8SCT systems.. and they
work flawlessly.

