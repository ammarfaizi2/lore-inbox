Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSK0KFv>; Wed, 27 Nov 2002 05:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSK0KFv>; Wed, 27 Nov 2002 05:05:51 -0500
Received: from rth.ninka.net ([216.101.162.244]:7344 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261874AbSK0KFu>;
	Wed, 27 Nov 2002 05:05:50 -0500
Subject: Re: 2.4.20-rc4 netfilter_ipv4 circular dependency
From: "David S. Miller" <davem@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8832.1038373821@kao2.melbourne.sgi.com>
References: <8832.1038373821@kao2.melbourne.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 02:34:56 -0800
Message-Id: <1038393296.14825.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 21:10, Keith Owens wrote:
> Warning on build of 2.4.20-rc4.
> 
> Circular include/linux/netfilter_ipv4/ip_conntrack_helper.h <-
> include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped

Keith, please report this to the proper place, as per
MAINTAINERS that would be the netfilter lists.

They don't have time to read linux-kernel and it's only a common
courtesy to at least CC: such reports there.

Thanks.

