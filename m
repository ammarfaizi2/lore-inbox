Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbTECSrq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTECSrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:47:46 -0400
Received: from rth.ninka.net ([216.101.162.244]:25065 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263372AbTECSrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:47:45 -0400
Subject: Re: [PATCH 2.{4,5}.x] mod_timer fix for sch_cbq.c
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: davej@codemonkey.org.uk, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1051971380.2018.128.camel@lima.royalchallenge.com>
References: <1051971380.2018.128.camel@lima.royalchallenge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051973612.14504.7.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2003 07:53:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-03 at 07:16, Vinay K Nallamothu wrote:
> Hi,
> 
> sch_cbq.c: trivial {del,add}_timer to mod_timer conversions.

Vinay, I sent you email earlier today saying that you
need to send networking patches to the networking lists
and to the networking maintainers.

Yet, you're still shoveling these patches to lkml.
What is the problem?

-- 
David S. Miller <davem@redhat.com>
