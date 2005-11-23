Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVKWXg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVKWXg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVKWXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:36:58 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64134 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751318AbVKWXg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:36:56 -0500
Message-ID: <4384FD13.7060606@pobox.com>
Date: Wed, 23 Nov 2005 18:36:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, Andrew Grover <andrew.grover@intel.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>	 <4384E7F2.2030508@pobox.com>  <20051123223007.GA5921@wotan.suse.de> <1132790740.13095.53.camel@localhost.localdomain>
In-Reply-To: <1132790740.13095.53.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > Might also be interesting to use one
	half of a hypedthread CPU as a > copier using the streaming
	instructions, might be better than turning it > off to improve
	performance ? That's pretty interesting too... [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Might also be interesting to use one half of a hypedthread CPU as a
> copier using the streaming instructions, might be better than turning it
> off to improve performance ?

That's pretty interesting too...

	Jeff


