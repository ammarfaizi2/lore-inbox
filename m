Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUDOUlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUDOUjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:39:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50822 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263151AbUDOUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:39:20 -0400
Date: Thu, 15 Apr 2004 21:50:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Konstantin Sobolev <kos@supportwizard.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: poor sata performance on 2.6
Message-ID: <20040415195053.GP468@openzaurus.ucw.cz>
References: <200404150236.05894.kos@supportwizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404150236.05894.kos@supportwizard.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I recently got a new sata disk and must say that it's performace is totally 
> unacceptable, on both siimage and sata_sil drivers. DMA is turned on.
...
> /dev/hde:
>  Timing buffer-cache reads:   1436 MB in  2.00 seconds = 717.03 MB/sec
>  Timing buffered disk reads:  100 MB in  3.03 seconds =  32.95 MB/sec

33MB/sec "totally unacceptable"? Wow.

> * Did you receive a proper socialist education?			      

Only half of it ;-)

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

