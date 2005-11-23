Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVKWVkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVKWVkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVKWVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:40:18 -0500
Received: from mail.dvmed.net ([216.237.124.58]:59781 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932546AbVKWVkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:40:15 -0500
Message-ID: <4384E1BC.4090708@pobox.com>
Date: Wed, 23 Nov 2005 16:40:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
References: <437D2DED.5030602@pobox.com> <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de> <20051118215209.GA9425@havoc.gtf.org> <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de> <Pine.LNX.4.63.0511221809430.24388@dingo.iwr.uni-heidelberg.de>
In-Reply-To: <Pine.LNX.4.63.0511221809430.24388@dingo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Bogdan Costescu wrote: > 1. several badblocks tests
	finished fine; the speed is also fine (about > 50Mbytes/s both read and
	write as reported by both iostat during > badblocks and bonnie++ on an
	ext2 FS). [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> 1. several badblocks tests finished fine; the speed is also fine (about 
> 50Mbytes/s both read and write as reported by both iostat during 
> badblocks and bonnie++ on an ext2 FS).

cool


> 2. I know that we are not yet talking about hotplugging, but this is 
> what happens if you do it (unplug) :-)

expected (unfortunately...)

	Jeff


