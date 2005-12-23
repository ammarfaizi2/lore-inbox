Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVLWCRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVLWCRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbVLWCRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:17:17 -0500
Received: from mail.dvmed.net ([216.237.124.58]:11709 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030371AbVLWCRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:17:16 -0500
Message-ID: <43AB5E12.5050208@pobox.com>
Date: Thu, 22 Dec 2005 21:16:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Paul Rolland <rol@witbe.net>, "'Arjan van de Ven'" <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
References: <1135164891.3456.11.camel@laptopd505.fenrus.org> <200512211140.jBLBeGD31936@tag.witbe.net> <20051223015752.GD27525@stusta.de>
In-Reply-To: <20051223015752.GD27525@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Adrian Bunk wrote: > On Wed, Dec 21, 2005 at 12:40:18PM
	+0100, Paul Rolland wrote: >>My first idea was to consider this as an
	opportunity to upgrade to the >>latest 2.4.x kernel, but reading you,
	this looks like a bad idea... >>2.6.x would be better ? > > > RHES3
	doesn't support kernel 2.6. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Dec 21, 2005 at 12:40:18PM +0100, Paul Rolland wrote:
>>My first idea was to consider this as an opportunity to upgrade to the
>>latest 2.4.x kernel, but reading you, this looks like a bad idea...
>>2.6.x would be better ?
> 
> 
> RHES3 doesn't support kernel 2.6.

Kernel 2.6.x will boot just fine, on RHEL3 userland.

It is not -supported- in the commercial sense, however.

	Jeff



