Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUGEBeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUGEBeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 21:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUGEBeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 21:34:44 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:13486 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S265891AbUGEBen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 21:34:43 -0400
Date: Sun, 4 Jul 2004 21:34:43 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata: 2.6.7-bk6,12 hang with ata_piix in combined mode; -bk5 ok
Message-ID: <20040705013443.GA8323@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20040630005420.GA4163@ti64.telemetry-investments.com> <40E8466B.9000702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E8466B.9000702@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:03:23PM -0400, Jeff Garzik wrote:
> If "acpi=off" does not fix this, please test the patch I posted recently
> 	[PATCH,RFT] SATA interrupt handling
 
acpi=off did not, nor did the half-dozen patches that had backed out.

But your patch most definitely did.  Thanks, I owe you a *case* of beer. :-)

	Bill Rugolsky
