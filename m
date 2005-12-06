Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVLFTYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVLFTYe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVLFTYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:24:34 -0500
Received: from mail.dvmed.net ([216.237.124.58]:13720 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030196AbVLFTYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:24:32 -0500
Message-ID: <4395E568.1020407@pobox.com>
Date: Tue, 06 Dec 2005 14:24:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Jiri Benc <jbenc@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <20051205191008.GA28433@infradead.org> <20051205203121.48241a08@griffin.suse.cz> <20051205194146.GA29317@infradead.org> <20051205211107.61941ab9@griffin.suse.cz> <20051206150909.GB1999@elf.ucw.cz>
In-Reply-To: <20051206150909.GB1999@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Pavel Machek wrote: > No, it does not work like that.
	You don't get nice, reviewable, > mergeable patches by developing code
	independently for 3 years or so > then attempting merge. > > If
	devicescape code is better than mainline, merge it _now_. If it is >
	not, drop it and start from mainline code. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> No, it does not work like that. You don't get nice, reviewable,
> mergeable patches by developing code independently for 3 years or so
> then attempting merge.
> 
> If devicescape code is better than mainline, merge it _now_. If it is
> not, drop it and start from mainline code.

Agreed.

	Jeff


