Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVKXQqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVKXQqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVKXQqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:46:55 -0500
Received: from mail.dvmed.net ([216.237.124.58]:60299 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932390AbVKXQqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:46:54 -0500
Message-ID: <4385EE73.1020709@pobox.com>
Date: Thu, 24 Nov 2005 11:46:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Daniel Drake <dsd@gentoo.org>, Jan Panoch <jan@panoch.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] PATA support for Intel ICH7 (intel 945G chipset) - 2.6.14.2
References: <4383DC5E.3050601@panoch.net> <438453C9.4050200@gentoo.org> <4385D79E.5060107@rtr.ca>
In-Reply-To: <4385D79E.5060107@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Mark Lord wrote: > Daniel Drake wrote: > >> >>
	Documentation/SubmittingPatches). I don't think it will be accepted >>
	because this hardware is already supported by the ata_piix libata
	driver. > > > That is not a valid reason to reject -- libata is still
	considered > very experimental for ATAPI devices, which are not enabled
	by default. > > Jeff has said that he prefers (at present) for people
	with ATAPI drives > to use the IDE layer rather than libata, where
	possible. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Daniel Drake wrote:
> 
>>
>> Documentation/SubmittingPatches). I don't think it will be accepted 
>> because this hardware is already supported by the ata_piix libata driver.
> 
> 
> That is not a valid reason to reject -- libata is still considered
> very experimental for ATAPI devices, which are not enabled by default.
> 
> Jeff has said that he prefers (at present) for people with ATAPI drives
> to use the IDE layer rather than libata, where possible.

PATA ATAPI, not all ATAPI...

	Jeff



