Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUGRBvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUGRBvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 21:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUGRBvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 21:51:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46544 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263733AbUGRBvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 21:51:23 -0400
Date: Sat, 17 Jul 2004 18:01:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: observations of swsusp and s3
Message-ID: <20040717160107.GH8264@openzaurus.ucw.cz>
References: <20040716120110.GA26122@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716120110.GA26122@butterfly.hjsoft.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1. using kernel 2.6.7 on my dell inspiron 3800, i've noticed that the 
> clock that assigns start times to processes is running behind, and i 
> suspect it could have something to do with having suspended (s4) the 
> machine:

Search archives, I have very hacky fix.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

