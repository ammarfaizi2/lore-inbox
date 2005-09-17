Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVIQC2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVIQC2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 22:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIQC2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 22:28:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48267 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750827AbVIQC2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 22:28:06 -0400
Date: Sat, 17 Sep 2005 04:27:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <Pine.LNX.4.61.0509170350200.3728@scrub.home>
Message-ID: <Pine.LNX.4.61.0509170423570.3743@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
 <20050912043943.5795d8f8.akpm@osdl.org> <20050912075155.3854b6e3.pj@sgi.com>
 <Pine.LNX.4.61.0509121821270.3743@scrub.home> <20050912153135.3812d8e2.pj@sgi.com>
 <Pine.LNX.4.61.0509131120020.3728@scrub.home> <20050913103724.19ac5efa.pj@sgi.com>
 <Pine.LNX.4.61.0509141446590.3728@scrub.home> <20050914124642.1b19dd73.pj@sgi.com>
 <Pine.LNX.4.61.0509150116150.3728@scrub.home> <20050915104535.6058bbda.pj@sgi.com>
 <Pine.LNX.4.61.0509170350200.3728@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 17 Sep 2005, Roman Zippel wrote:

> Define "using", as long as the count is different from the cpuset is 
> active and the possible actions on it are limited.

Oops, add a "zero," after "from" to make this an understandable sentence. :)

bye, Roman
