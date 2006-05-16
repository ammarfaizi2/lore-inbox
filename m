Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWEPKLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWEPKLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 06:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWEPKLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 06:11:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33705 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751735AbWEPKLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 06:11:22 -0400
Subject: Re: /dev/random on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Jonathan Day <imipak@yahoo.com>,
       linux-kernel@vger.kernel.org, Zvika Gutterman <zvi@safend.com>
In-Reply-To: <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com>
	 <1147732867.26686.188.camel@localhost.localdomain>
	 <20060516025003.GC18645@rhun.haifa.ibm.com>
	 <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 11:24:04 +0100
Message-Id: <1147775045.2151.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-16 at 04:15 -0400, Kyle Moffett wrote:
> > Zvi did contact Matt Mackall, the current /dev/random maintainer,  
> > and was very keen on discussing the paper with him. I don't think  
> > he got any response.
> 
> So he's demanding that one person spend time responding to his  
> paper? 

Relying on email to one person getting through is a bit bogus, but I
don't see a single demand from anyone that someone respond to the paper.
I'm very glad the work was done, it would have been nicer to have known
up front but it didn't work out.

Also if the maintainer doesn't respond and the paper authors didn't know
where to go next that in itself needs addressing because the same may be
true for others finding problems.

Don't blame the messenger when it might be useful to think about whether
the MAINTAINERS file could do with an extra paragraph or two...

Alan
