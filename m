Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVCLAEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVCLAEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCLAB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:01:27 -0500
Received: from mulder.f5.com ([205.229.151.150]:43239 "EHLO mail.f5.com")
	by vger.kernel.org with ESMTP id S261818AbVCKX5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:57:30 -0500
User-Agent: Microsoft-Entourage/10.1.6.040913.0
Date: Fri, 11 Mar 2005 15:57:30 -0800
Subject: Re: [load balancing] F5 kernel source mods released
From: Bill Whitson <b.whitson@f5.com>
To: <lb-l@vegan.net>, <linux-kernel@vger.kernel.org>
Message-ID: <BE57706A.ABBA%b.whitson@f5.com>
In-Reply-To: <422D7070.8040405@travellingkiwi.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2005 23:57:23.0567 (UTC) FILETIME=[11CF37F0:01C52696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before anyone gets too excited, the modifications to the GPL licensed code
will not provide you with a working load-balancer, or anything remotely
close.  The majority of the traffic processing in BIG-IP version 9.x is
handled by the traffic management microkernel, which is unique code.

Sorry, you can't hack together your own version of BIG-IP ;).

-- 
Bill Whitson
Solutions Engineer
AskF5

Desk: 206-272-6587
Mobile: 206-604-7048
b.whitson@f5.com

AskF5: http://tech.f5.com/


On 3/8/05 1:29 AM, "Hamie" <hamish@travellingkiwi.com> wrote:

> 
> F5 (Manufacturers of the BigIP load balancers) have released their
> modified kernel sources & any other bits that are obliged under the GPL
> for their Linux (2.4.21 it looks like) based version 9.x of bigIP. If
> customers wish to get hold of the sources, then there is a solution note
> on theoir website with instructions on how to get the code.
> 
> I haven't tried compiling it yet to see that it's complete, but if
> anyone would like it uploaded somewhere for playing with let me know.
> 
> Hamish Marson.
> ____________________
> The Load Balancing Mailing List
> Unsubscribe:    mailto:majordomo@vegan.net?body=unsubscribe%20lb-l
> Archive:        http://vegan.net/lb/archive
> LBDigest:       http://lbdigest.com
> MRTG with SLB:  http://vegan.net/MRTG
> Hosted by:    http://www.tokkisystems.com
> 


