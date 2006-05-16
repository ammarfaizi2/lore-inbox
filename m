Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWEPI3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWEPI3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWEPI3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:29:04 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:38268 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751685AbWEPI3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:29:03 -0400
Date: Tue, 16 May 2006 11:28:59 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Day <imipak@yahoo.com>,
       linux-kernel@vger.kernel.org, Zvika Gutterman <zvi@safend.com>
Subject: Re: /dev/random on Linux
Message-ID: <20060516082859.GD18645@rhun.haifa.ibm.com>
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com> <1147732867.26686.188.camel@localhost.localdomain> <20060516025003.GC18645@rhun.haifa.ibm.com> <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 04:15:19AM -0400, Kyle Moffett wrote:
> On May 15, 2006, at 22:50, Muli Ben-Yehuda wrote:
> >On Mon, May 15, 2006 at 11:41:07PM +0100, Alan Cox wrote:
> >>A paper by people who can't work out how to mail linux-kernel or  
> >>vendor-sec, or follow "REPORTING-BUGS" in the source,
> >
> >Zvi did contact Matt Mackall, the current /dev/random maintainer,  
> >and was very keen on discussing the paper with him. I don't think  
> >he got any response.
> 
> So he's demanding that one person spend time responding to his  
> paper? 

Who said anything about demanding? he wanted to discuss the paper. He
received no response (AFAIK). Please don't read more into it.

> The "maintainer" for any given piece of the kernel is the  
> entry in MAINTAINERS *and* linux-kernel@vger.kernel.org *and* the  
> appropriate sub-mailing-list.

For security related information, it is sometimes best not to tell the
whole world about it immediately (although you should definitely tell
the whole world about it eventually). It should've probably been
posted to lkml when mpm didn't respond, I agree. I'll take the blame
for not suggesting that to Zvi.

Cheers,
Muli
