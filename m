Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVKOUUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVKOUUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKOUUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:20:47 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1971 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S965014AbVKOUUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:20:47 -0500
Message-ID: <437A4315.6040604@nortel.com>
Date: Tue, 15 Nov 2005 14:20:37 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: evan@coolrunningconcepts.com, linux-kernel@vger.kernel.org
Subject: Re: Timer idea
References: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com> <Pine.LNX.4.61.0511151401400.6145@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511151401400.6145@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2005 20:20:38.0885 (UTC) FILETIME=[0B45F950:01C5EA22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

> On ix86 machines, basic time comes from chip(s), read from ports.
> That's just another tiny little problem.

I'm sure you already know this, but x86 can also use the HPET for 
timestamps, as well as the TSC if it's available.

Chris
