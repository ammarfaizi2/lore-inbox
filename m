Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWFITYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWFITYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWFITYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:24:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57242 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030442AbWFITYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:24:03 -0400
Message-ID: <4489CACE.5080701@garzik.org>
Date: Fri, 09 Jun 2006 15:23:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Mike Snitzer <snitzer@gmail.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hch@infradead.org, cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org>	<20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org>	<20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org>	<20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org>	<4489B719.2070707@garzik.org>	<170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com>	<4489C3D5.4030905@garzik.org> <m3odx26snk.fsf@bzzz.home.net>
In-Reply-To: <m3odx26snk.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> what if proposed patch is safer than an average fix?
> (given that it's just out of usage unless enabled)

Regardless of how you phrase it, it is an inescapable fact that you are 
developing new stuff in the main, supposedly-stable Linux filesystem.

	Jeff



