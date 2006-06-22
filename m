Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWFVX5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWFVX5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWFVX5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:57:36 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:14302 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750901AbWFVX5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:57:35 -0400
Date: Fri, 23 Jun 2006 01:53:56 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Danial Thom <danial_thom@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-ID: <20060622235356.GA31168@electric-eye.fr.zoreil.com>
References: <20060622175724.GA28913@electric-eye.fr.zoreil.com> <20060622224759.25253.qmail@web33315.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622224759.25253.qmail@web33315.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom <danial_thom@yahoo.com> :
[...]
> systat". Plus its clear that the guy who gave the
> answer doesn't know what he's talking about,
> since he's actually trying to explain away the
> problem as being normal. 

"75 kpps means 10% of the max load" was quite fun too.

[...]
> the system is perpetually 100% idle but its
> dropping packets due to excessive backlog.

No difference when you renice ksoftirqd to a strongly
negative value ?

-- 
Ueimor
