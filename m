Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVJJRBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVJJRBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVJJRBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:01:04 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:64463 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750947AbVJJRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:01:02 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Vivek Kutal <vivek.kutal@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_HIGHMEM query
Date: Mon, 10 Oct 2005 17:00:57 +0000
Message-Id: <101020051700.15287.434A9E49000633AF00003BB7220922462700009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KernelTrap has an good article explaining the details of HIGHMEM - http://kerneltrap.org/node/2450

Parag


> Hello Everyone ,
> All books that I have read say that the concept of ZONE_HIGHMEM is
> introduced because some architectures cannot directly map memory
> beyond 896MB (x86).
> 
> My question is What is direct mapping(does it mean, same virtual
> address and physical address) and why cant a architecture directly map
> a particular region in the memory?
> 
> 
> 
> --
> Thanks and Regards
> Vivek Kutal
> http://vivekkutal.blogspot.com
> 
>            "Live as if you were to die tomorrow. Learn as if you were
> to live forever."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
