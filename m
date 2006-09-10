Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWIJQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWIJQov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWIJQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:44:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37013 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932303AbWIJQou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:44:50 -0400
Message-ID: <450440EF.9050103@garzik.org>
Date: Sun, 10 Sep 2006 12:44:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Daniel Drake <dsd@gentoo.org>, akpm@osdl.org, torvalds@osdl.org,
       sergio@sergiomb.no-ip.org, greg@kroah.com, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, harmon@ksu.edu,
       len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
References: <20060907223313.1770B7B40A0@zog.reactivated.net>	 <1157811641.6877.5.camel@localhost.localdomain>	 <4502D35E.8020802@gentoo.org>	 <1157817836.6877.52.camel@localhost.localdomain>	 <45033370.8040005@gentoo.org>	 <1157848272.6877.108.camel@localhost.localdomain>	 <450436F1.8070203@gentoo.org> <1157906395.23085.18.camel@localhost.localdomain>
In-Reply-To: <1157906395.23085.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The detailed stuff I posted by digging over all the docs should be
> enough to figure out WTF is actually going on and fix the stuff
> properly. 

FWIW, older VIA docs are also posted at 
http://gkernel.sourceforge.net/specs/via/

	Jeff


