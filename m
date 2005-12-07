Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVLGCO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVLGCO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 21:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVLGCO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 21:14:58 -0500
Received: from mail.dvmed.net ([216.237.124.58]:16795 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964845AbVLGCO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 21:14:58 -0500
Message-ID: <43964586.3080300@pobox.com>
Date: Tue, 06 Dec 2005 21:14:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de> <4391FC0A.9040202@pobox.com> <20051207003922.GA18528@kroah.com>
In-Reply-To: <20051207003922.GA18528@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Greg KH wrote: > On Sat, Dec 03, 2005 at 03:11:54PM
	-0500, Jeff Garzik wrote: > >>The first two patches could go in
	immediately, the last should probably >>wait a bit... > > > What is the
	rush? These seem pretty late for the -rc series :) > > I'll send them
	in after 2.6.15 is out, is that ok? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Dec 03, 2005 at 03:11:54PM -0500, Jeff Garzik wrote:
> 
>>The first two patches could go in immediately, the last should probably 
>>wait a bit...
> 
> 
> What is the rush?  These seem pretty late for the -rc series :)
> 
> I'll send them in after 2.6.15 is out, is that ok?

You were supposed to read my mind :)  "immediately" meant "ok for 
upstream when -rc cycle closes" :)  The third patch I don't consider 
ready for upstream, -rc or no.

So post-2.6.15 is quite fine, that's what I expected.

	Jeff


