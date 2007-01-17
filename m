Return-Path: <linux-kernel-owner+w=401wt.eu-S1751799AbXAQWN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXAQWN0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXAQWN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:13:26 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51377 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbXAQWNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:13:25 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 17 Jan 2007 17:07:34 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce two new maturlty levels:  DEPRECATED and
 OBSOLETE.
In-Reply-To: <45AE9B85.7090608@zytor.com>
Message-ID: <Pine.LNX.4.64.0701171706330.4353@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
 <45AE9B85.7090608@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, H. Peter Anvin wrote:

> DEPRECATED should presumably default to Y; OBSOLETE to n.

crap, now i see what you were getting at -- i forgot to assign
defaults.  i'll resubmit, but i'll wait for anyone to suggest any
better help content if they have a better idea.

rday
