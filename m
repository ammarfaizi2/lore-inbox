Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUF3SDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUF3SDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUF3SDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:03:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266488AbUF3SDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:03:12 -0400
Message-ID: <40E3004F.5040907@pobox.com>
Date: Wed, 30 Jun 2004 14:02:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata: 2.6.7-bk6,12 hang with ata_piix in combined mode; -bk5
 ok
References: <20040630005420.GA4163@ti64.telemetry-investments.com> <20040630012051.GA30823@havoc.gtf.org> <20040630155608.GA19785@ti64.telemetry-investments.com>
In-Reply-To: <20040630155608.GA19785@ti64.telemetry-investments.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Rugolsky Jr. wrote:
> On Tue, Jun 29, 2004 at 09:20:51PM -0400, Jeff Garzik wrote:
>>Also, does disabling combined mode solve anything?
> 
> 
> AFAICT, Dell's BIOS offers no option for changing the SATA mode.
> ("Cable Select" for the new millenium! Arrgh!)
> 
> If a diff of the boot logs shows nothing useful, I will try backing out
> individual patches from patch-2.6.7-bk5-bk6.bz2.


Please do, that would be a big help...

	Jeff


