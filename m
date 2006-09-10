Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWIJTGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWIJTGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWIJTGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:06:15 -0400
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:30856 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932508AbWIJTGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:06:14 -0400
Message-ID: <4504621E.5090202@gentoo.org>
Date: Sun, 10 Sep 2006 15:06:06 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
References: <20060907223313.1770B7B40A0@zog.reactivated.net>	 <1157811641.6877.5.camel@localhost.localdomain>	 <4502D35E.8020802@gentoo.org>	 <1157817836.6877.52.camel@localhost.localdomain>	 <45033370.8040005@gentoo.org>	 <1157848272.6877.108.camel@localhost.localdomain>	 <450436F1.8070203@gentoo.org> <1157906395.23085.18.camel@localhost.localdomain>
In-Reply-To: <1157906395.23085.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Basically we are going around in circles inventing new random
> hypothetical rule sets that may or may not fix the problem. You can do
> this for years, in fact we *have* been doing this for years.
> 
> The detailed stuff I posted by digging over all the docs should be
> enough to figure out WTF is actually going on and fix the stuff
> properly. 

OK - I'll try and figure out what is going on in Stian's case. Thanks 
for the info.

Daniel
