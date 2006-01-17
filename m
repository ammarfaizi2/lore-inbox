Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWAQN0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWAQN0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWAQN0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:26:03 -0500
Received: from mail.dvmed.net ([216.237.124.58]:6315 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932472AbWAQN0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:26:01 -0500
Message-ID: <43CCF067.2050409@pobox.com>
Date: Tue, 17 Jan 2006 08:25:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Pre UDMA EIDE PIO mode selection
References: <1136826880.6659.49.camel@localhost.localdomain>
In-Reply-To: <1136826880.6659.49.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > I misread the spec when doing the
	original. I've tested the corrected > version with pre UDMA drives and
	it now picks the right modes. This is a > specific bug fix rather than
	an update or new feature item. > > Signed-off-by: Alan Cox
	<alan@redhat.com> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I misread the spec when doing the original. I've tested the corrected
> version with pre UDMA drives and it now picks the right modes. This is a
> specific bug fix rather than an update or new feature item.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to 'upstream'


