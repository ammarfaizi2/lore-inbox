Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUGPRKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUGPRKm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUGPRKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:10:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19127 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266599AbUGPRKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:10:38 -0400
Date: Fri, 16 Jul 2004 18:43:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>,
       lkcd-devel@lists.sourceforge.net
Subject: Re: [RFC] Standard filesystem types for crash dumping
Message-ID: <20040716164334.GB8264@openzaurus.ucw.cz>
References: <11077.1089790663@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11077.1089790663@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This RFC proposes a common interface to handle the above points.  In
> the true Unix way (everything is a file), it adds two new filesystem
> types, dump_0 and dump_1.

Maybe call these dump_empty and dump_full?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

