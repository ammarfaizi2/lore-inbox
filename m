Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVLHBGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVLHBGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 20:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbVLHBGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 20:06:11 -0500
Received: from mail.dvmed.net ([216.237.124.58]:51108 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030404AbVLHBGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 20:06:09 -0500
Message-ID: <439786F6.8020709@pobox.com>
Date: Wed, 07 Dec 2005 20:05:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Wu <flamingice@sourmilk.net>
CC: netdev@vger.kernel.org, Jiri Benc <jbenc@suse.cz>,
       Christoph Hellwig <hch@infradead.org>, Joseph Jezak <josejx@gentoo.org>,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
Subject: Re: Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205191008.GA28433@infradead.org> <20051205203121.48241a08@griffin.suse.cz> <200512071900.27669.flamingice@sourmilk.net>
In-Reply-To: <200512071900.27669.flamingice@sourmilk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Michael Wu wrote: > The softmac code that is still in
	adm8211 is actually based on an early > version of the softmac code
	that Jouni made for Devicescape. The Devicescape > code does much more
	useful stuff than the code currently in the kernel. Sure, > I can and
	have been porting adm8211 to the new kernel stuff.. but it already >
	works with a much more mature piece of softmac code. I see the use of
	Intel's > 802.11 code as a step backwards. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Wu wrote:
> The softmac code that is still in adm8211 is actually based on an early 
> version of the softmac code that Jouni made for Devicescape. The Devicescape 
> code does much more useful stuff than the code currently in the kernel. Sure, 
> I can and have been porting adm8211 to the new kernel stuff.. but it already 
> works with a much more mature piece of softmac code. I see the use of Intel's 
> 802.11 code as a step backwards.

Then please update the code in the kernel.

	Jeff


