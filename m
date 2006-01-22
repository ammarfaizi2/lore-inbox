Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWAVER5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWAVER5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 23:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAVER5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 23:17:57 -0500
Received: from mail.dvmed.net ([216.237.124.58]:13795 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932371AbWAVER5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 23:17:57 -0500
Message-ID: <43D30760.4090400@pobox.com>
Date: Sat, 21 Jan 2006 23:17:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DocBook: fix some comments in drivers/scsi
References: <20060121214011.GD30777@admingilde.org>
In-Reply-To: <20060121214011.GD30777@admingilde.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Martin Waitz wrote: > Update some kernel-doc comments
	to match the code > > Signed-off-by: Martin Waitz <tali@admingilde.org>
	> > --- > > drivers/scsi/ata_piix.c | 1 + > drivers/scsi/libata-core.c
	| 31 +++++++++++++++++ > drivers/scsi/libata-scsi.c | 2 ++ [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> Update some kernel-doc comments to match the code
> 
> Signed-off-by: Martin Waitz <tali@admingilde.org>
> 
> ---
> 
>  drivers/scsi/ata_piix.c    |    1 +
>  drivers/scsi/libata-core.c |   31 +++++++++++++++++--------------
>  drivers/scsi/libata-scsi.c |    2 ++

Please copy the maintainer (me and linux-ide), particularly since there 
are other patches in this area...

	Jeff



