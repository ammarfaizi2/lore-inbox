Return-Path: <linux-kernel-owner+w=401wt.eu-S932462AbXARQ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbXARQ00 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXARQ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:26:26 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:32775 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbXARQ0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:26:25 -0500
X-Originating-Ip: 74.109.98.130
Date: Thu, 18 Jan 2007 11:20:36 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH]  Centralize the macro definition of "__packed".
In-Reply-To: <Pine.LNX.4.64.0701180959470.19826@CPE00045a9c397f-CM001225dbafb6>
Message-ID: <Pine.LNX.4.64.0701181120050.21236@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701180959470.19826@CPE00045a9c397f-CM001225dbafb6>
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

On Thu, 18 Jan 2007, Robert P. J. Day wrote:

>   Centralize the attribute macro definition of "__packed" so no
> subsystem has to do that explicitly.

ummm ... might want to ignore this submission, i want to do some
tweaking first.  sorry.

rday
