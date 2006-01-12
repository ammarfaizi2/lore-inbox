Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWALDZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWALDZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWALDZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:25:58 -0500
Received: from mail.dvmed.net ([216.237.124.58]:46041 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965010AbWALDZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:25:58 -0500
Message-ID: <43C5CC41.1060502@pobox.com>
Date: Wed, 11 Jan 2006 22:25:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rajeev V. Pillai" <rajeevvp@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Removal of PCI_VENDOR_ID_RENDITION from 2.6.15
References: <Pine.LNX.4.64.0601120752320.1259@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0601120752320.1259@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Rajeev V. Pillai wrote: > Why were the RENDITION
	related PCI Vendor and device IDs removed from > 2.6.15? Svgalib, for
	one, depends on it. If its not used in the kernel source code, it
	doesn't belong in the kernel source code. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev V. Pillai wrote:
> Why were the RENDITION related PCI Vendor and device IDs removed from
> 2.6.15?  Svgalib, for one, depends on it.

If its not used in the kernel source code, it doesn't belong in the 
kernel source code.

	Jeff



