Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWHXOob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWHXOob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWHXOob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:44:31 -0400
Received: from rtr.ca ([64.26.128.89]:13954 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964946AbWHXOoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:44:30 -0400
Message-ID: <44EDBB4C.6040203@rtr.ca>
Date: Thu, 24 Aug 2006 10:44:28 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca> <20060811210104.GL26930@redhat.com> <44DCF360.7050305@rtr.ca> <44DCF5C1.4040506@rtr.ca> <20060818151122.GA8275@ucw.cz>
In-Reply-To: <20060818151122.GA8275@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>
> trip_points should be writeable... but you do not have passive cooling
> enabled there?!

What do you mean -- I don't understand what you were trying to say
(probably just a language thing).

By definition, "passive" cooling never needs enabling -- this just refers
to things like heat sinks and air vents.

"Active" cooling is the term for fans and pumps and such.

Cheers

