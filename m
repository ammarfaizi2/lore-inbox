Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWACSx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWACSx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWACSx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:53:29 -0500
Received: from mail.dvmed.net ([216.237.124.58]:7570 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932478AbWACSx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:53:28 -0500
Message-ID: <43BAC822.6090501@pobox.com>
Date: Tue, 03 Jan 2006 13:53:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year, libata hackers
References: <43BAB977.3010203@pobox.com> <20060103183328.GW2772@suse.de>
In-Reply-To: <20060103183328.GW2772@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jens Axboe wrote: > On Tue, Jan 03 2006, Jeff Garzik
	wrote: > >>Port multiplier and NCQ (queueing) support are the two other
	big to-do >>items on the list. > > > I'll get NCQ updated and tested
	again in the not-so-distant future. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Jan 03 2006, Jeff Garzik wrote:
> 
>>Port multiplier and NCQ (queueing) support are the two other big to-do 
>>items on the list.
> 
> 
> I'll get NCQ updated and tested again in the not-so-distant future.

FWIW I've kept it moderately up-to-date in the 'ncq' branch.  It's 
definitely moldy, with a few FIXMEs in libata-scsi's read/write 
translation, for example, which is missing the NCQ portion of that code.

	Jeff



