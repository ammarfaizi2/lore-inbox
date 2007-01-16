Return-Path: <linux-kernel-owner+w=401wt.eu-S1750773AbXAPSTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXAPSTa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbXAPST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:19:29 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:49436 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbXAPST3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:19:29 -0500
Date: Tue, 16 Jan 2007 10:16:33 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>, isely@pobox.com,
       video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
Message-Id: <20070116101633.39e57884.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
References: <20070116080136.GA30133@Ahmed>
	<Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007 03:36:16 -0500 (EST) Robert P. J. Day wrote:

> On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:
> 
> > Use ARRAY_SIZE macro in pvrusb2-hdw.c file
> >
> > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> 
> ... snip ...
> 
> i'm not sure it's worth submitting multiple patches to convert code
> expressions to the ARRAY_SIZE() macro since i was going to wait for
> the next kernel release, and do that in one fell swoop with a single
> patch.
> 
> but if people higher up the food chain think it's a better idea to do
> it a little at a time, that's fine.

I'm not strictly on the food chain, but these 4 patches to
pvrusb2 should have been sent as one patch IMO.

---
~Randy
