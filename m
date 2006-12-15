Return-Path: <linux-kernel-owner+w=401wt.eu-S965171AbWLOVuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWLOVuH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWLOVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:50:07 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:58282 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965171AbWLOVuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:50:06 -0500
Message-ID: <4583187A.4020602@garzik.org>
Date: Fri, 15 Dec 2006 16:49:46 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Neil Brown <neilb@suse.de>, Jurriaan <thunder7@xs4all.nl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
References: <20061204203410.6152efec.akpm@osdl.org> <20061215192146.GA3616@amd64.of.nowhere> <17795.2681.523120.656367@cse.unsw.edu.au> <200612152215.23629.rjw@sisk.pl>
In-Reply-To: <200612152215.23629.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> The other box is mine and it works just fine with 2.6.20-rc1.
> 
>> I think something bad happened in sata land just recently.
> 
> Yup.  Please see, for example:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116621656432500&w=2
> 
> It looks like the breakage is in sata, in the patches that went in after
> 2.6.19-rc6-mm2 (that one worked for me like charm).


So.... 2.6.20-rc1 works for you?

	Jeff


