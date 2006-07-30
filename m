Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWG3Q6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWG3Q6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWG3Q6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:58:14 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:8719 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751188AbWG3Q6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:58:14 -0400
Message-ID: <44CCE521.7090705@superbug.co.uk>
Date: Sun, 30 Jul 2006 17:58:09 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.5 (X11/20060730)
MIME-Version: 1.0
To: Kasper Sandberg <lkml@metanurb.dk>
CC: Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
References: <20060730104042.GE1920@elf.ucw.cz>	 <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org>	 <20060730114722.GA26046@srcf.ucam.org> <1154264478.13635.22.camel@localhost>
In-Reply-To: <1154264478.13635.22.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg wrote:
>> Because it would involve a moderate rewriting of the driver, and we'd 
>> have to carry a delta against Intel's code forever.
> without knowing this for sure, dont you think that if a largely changed
> version of the driver appeared in the tree, intel may start developing
> on that? cause then they wouldnt be the ones that "broke" compliance
> with FCC(hah) by not doing binaryonly.
> 

Where can I find this FCC law that seems to be crippling open source 
wlan development?

I am not from the USA, so I don't have to comply with the FCC. Could we 
make a non-crippled totally open source driver for use by people outside 
the USA?

For example, here in the UK one can own radios that can transmit on any 
frequency one likes, but if you actually press the TX button without a 
the appropriate License, you break the law.

James
