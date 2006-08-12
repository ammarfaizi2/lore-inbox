Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWHLNkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWHLNkI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 09:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWHLNkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 09:40:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:45502 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932513AbWHLNkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 09:40:06 -0400
Message-ID: <44DDDA2F.4080404@garzik.org>
Date: Sat, 12 Aug 2006 09:39:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
References: <200608121207.42268.rjw@sisk.pl> <20060812052853.f9e5d648.akpm@osdl.org>
In-Reply-To: <20060812052853.f9e5d648.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It would be good if you could poke around in gdb, work out exactly which
> statement it's oopsing at, please.

I'm also interested to know if the problem goes away when you disable 
preempt...

	Jeff


