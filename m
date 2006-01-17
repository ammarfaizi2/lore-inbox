Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWAQM5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWAQM5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWAQM5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:57:05 -0500
Received: from mail.dvmed.net ([216.237.124.58]:40874 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932452AbWAQM5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:57:03 -0500
Message-ID: <43CCE99C.1020800@pobox.com>
Date: Tue, 17 Jan 2006 07:57:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Gaston <jason.d.gaston@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15 6/6] ahci: AHCI mode SATA patch for Intel ICH8
References: <200601091109.14105.jason.d.gaston@intel.com>
In-Reply-To: <200601091109.14105.jason.d.gaston@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jason Gaston wrote: > Hello, > > This patch adds the
	Intel ICH8 DID's to the ahci.c file for AHCI mode SATA support. This
	patch was built against the 2.6.15 kernel. > If acceptable, please
	apply. > > Thanks, > > Jason Gaston > > Signed-off-by: Jason Gaston
	<Jason.d.gaston@intel.com> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gaston wrote:
> Hello,
> 
> This patch adds the Intel ICH8 DID's to the ahci.c file for AHCI mode SATA support.  This patch was built against the 2.6.15 kernel.  
> If acceptable, please apply. 
> 
> Thanks,
> 
> Jason Gaston
> 
> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

Patch applied, after hand-editing.

Please be aware that your email is copied via scripts directly into the 
kernel changelog.  As such,

* stuff like "hello," "thanks, jason gaston" must be hand-edited out.

* your subject line notes the kernel against which you generated the 
patch.  the sentence "This patch was built against the 2.6.15 kernel." 
had to be hand-edited out.

* "If acceptable, please apply." had to be hand-edited out.

