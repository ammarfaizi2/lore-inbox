Return-Path: <linux-kernel-owner+w=401wt.eu-S932464AbXAPIrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbXAPIrx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbXAPIrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:47:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58507 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464AbXAPIrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:47:52 -0500
X-Originating-Ip: 74.109.98.130
Date: Tue, 16 Jan 2007 03:36:16 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
cc: isely@pobox.com, video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
In-Reply-To: <20070116080136.GA30133@Ahmed>
Message-ID: <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
References: <20070116080136.GA30133@Ahmed>
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

On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:

> Use ARRAY_SIZE macro in pvrusb2-hdw.c file
>
> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>

... snip ...

i'm not sure it's worth submitting multiple patches to convert code
expressions to the ARRAY_SIZE() macro since i was going to wait for
the next kernel release, and do that in one fell swoop with a single
patch.

but if people higher up the food chain think it's a better idea to do
it a little at a time, that's fine.

rday
