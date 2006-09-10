Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWIJTT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWIJTT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWIJTT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:19:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58254 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932540AbWIJTT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:19:28 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
In-Reply-To: <4504621E.5090202@gentoo.org>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <450436F1.8070203@gentoo.org>
	 <1157906395.23085.18.camel@localhost.localdomain>
	 <4504621E.5090202@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 20:41:47 +0100
Message-Id: <1157917308.23085.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-10 am 15:06 -0400, ysgrifennodd Daniel Drake:
> Alan Cox wrote:
> > Basically we are going around in circles inventing new random
> > hypothetical rule sets that may or may not fix the problem. You can do
> > this for years, in fact we *have* been doing this for years.
> > 
> > The detailed stuff I posted by digging over all the docs should be
> > enough to figure out WTF is actually going on and fix the stuff
> > properly. 
> 
> OK - I'll try and figure out what is going on in Stian's case. Thanks 
> for the info.

Feel free to cc me the lspci data and partial diagnostics and I'll try
and help too.

