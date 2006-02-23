Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbWBWVKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWBWVKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWBWVKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:10:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5292 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751653AbWBWVKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:10:10 -0500
Date: Thu, 23 Feb 2006 22:08:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Gautam H Thaker <gthaker@atl.lmco.com>, linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Message-ID: <20060223210844.GA26701@elte.hu>
References: <43FE134C.6070600@atl.lmco.com> <20060223205851.GA24321@elte.hu> <29495f1d0602231306o55d759d5v9600b070a4b485e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0602231306o55d759d5v9600b070a4b485e3@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nish Aravamudan <nish.aravamudan@gmail.com> wrote:

> Would it make more sense to compare 2.6.15 and 2.6.15-rt17, as opposed 
> to 2.6.12-1.1390_FC4 and 2.6.15-rt17? Seems like the closer the two 
> kernels are, the easier it will be to isolate the differences.

good point. I'd expect there to be similar 'top' output, but still worth 
doing for comparable results.

	Ingo
