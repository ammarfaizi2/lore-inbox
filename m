Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVKBUv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVKBUv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbVKBUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:51:57 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:27621 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S965235AbVKBUv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:51:56 -0500
From: Steve Snyder <R00020C@freescale.com>
To: Antonio Vargas <windenntw@gmail.com>
Subject: Re: Can I reduce CPU use of conntrack/masq?
Date: Wed, 2 Nov 2005 15:51:52 -0500
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200511021450.47657.R00020C@freescale.com> <69304d110511021223m59716878qc247ab96d8c1e24e@mail.gmail.com>
In-Reply-To: <69304d110511021223m59716878qc247ab96d8c1e24e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021551.52823.R00020C@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 15:23, Antonio Vargas wrote:
> On 11/2/05, Steve Snyder <R00020C@freescale.com> wrote:
[snip]
> > I wonder if I can improve conntrack/masq performance at the expense of
> > flexibility.  This will be a closed system, with simple and static
> > routing.  Are there any trade-offs I can make to sacrifice unneeded
> > flexibility in routing for reduced CPU utilization in conntrack/masq?
> 
> Hmmm... totally untested and don't know the details of UWB but...
> can't you simply ether-bridge the interfaces instead of masquerading?
> It should need less CPU

Hmm...  I'm not familiar with ether-bridge, and Google turns up only
commercial products and BSD references.

Pointer to info, please?

Thanks.
