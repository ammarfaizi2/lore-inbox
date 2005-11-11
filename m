Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVKKOMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKKOMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKKOMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:12:13 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61619 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750776AbVKKOMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:12:13 -0500
Date: Fri, 11 Nov 2005 15:11:21 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to speed up raid1 resync ?
Message-ID: <20051111141121.GA19427@electric-eye.fr.zoreil.com>
References: <1131717619.4133.13.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1131717619.4133.13.camel@rousalka.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot <nicolas.mailhot@laposte.net> :
[...]
> Is there a way to speed it up ? I don't want to wait 1164.8min, and I
> don't care if the resync monopolises most of the system.

Naïve question: what do the sysctl dev.raid.speed_limit_{min/max} say ?

--
Ueimor
