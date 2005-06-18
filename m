Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVFTUMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVFTUMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFTULT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:11:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48083 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261507AbVFTUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:10:25 -0400
Date: Sat, 18 Jun 2005 19:01:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Philippe Gerum <rpm@xenomai.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] I-pipe: Core implementation
Message-ID: <20050618170139.GA477@openzaurus.ucw.cz>
References: <42B35B07.7080703@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B35B07.7080703@xenomai.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  linux-2.6.12-rc6-ipipe-0.5/ipipe/Kconfig         |   12
>  linux-2.6.12-rc6-ipipe-0.5/ipipe/Makefile        |    9
>  linux-2.6.12-rc6-ipipe-0.5/ipipe/generic.c       |  265 ++++++++++++

Top-level directory for 3 files seems a bit excessive to me...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

